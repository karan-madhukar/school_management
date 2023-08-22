defmodule SchoolManagement.Students do
  @moduledoc """
  Defines all the funsction related to students
  """

  import Ecto.Query

  alias Ecto.Multi

  alias SchoolManagement.Repo
  alias SchoolManagement.Students.{Attendance, Student}
  alias SchoolManagement.Students.Constants

  def get_attendance(id), do: Repo.get(Attendance, id)

  def get_attendance_by_date_and_student_ids(date, student_ids) do
    from(a in Attendance,
      where: a.date == ^date and a.student_id in ^student_ids
    )
  end

  def filter_student_ids_by_school_class_and_section(school_id, class_id, section_id) do
    from(s in Student,
      where:
        s.school_id == ^school_id and
          s.class_id == ^class_id and s.section_id == ^section_id and is_nil(s.date_of_leaving),
      select: s.id
    )
    |> Repo.all()
  end

  def list_students_by_school_class_and_section(school_id, class_id, section_id) do
    from(s in Student,
      where: s.school_id == ^school_id and s.class_id == ^class_id and s.section_id == ^section_id
    )
    |> Repo.all()
  end

  # will Fetch school id from current user
  def create_or_update_attendances(%{
        "students_status" => students_status,
        "date" => date,
        "school_id" => school_id,
        "class_id" => class_id,
        "section_id" => section_id
      }) do
    section_student_ids =
      filter_student_ids_by_school_class_and_section(school_id, class_id, section_id)

    {:ok, date} = Date.from_iso8601(date)

    with true <- Timex.diff(date, Date.utc_today(), :day) < 1,
         {:error, _reason} = output <-
           verify_and_filter_students_status(students_status, section_student_ids) do
      output
    else
      {students_status, student_ids} ->
        mark_attendance_based_on_status(date, student_ids, students_status)

      false ->
        {:error, "Date should not be in future."}
    end
  end

  defp verify_and_filter_students_status(students_status, section_student_ids) do
    Enum.reduce_while(students_status, {[], []}, fn ss, {students_status_list, student_ids} ->
      if ss["student_id"] in section_student_ids and
           ss["forenoon_status"] in Constants.Attendance.statuses() and
           ss["afternoon_status"] in Constants.Attendance.statuses() do
        {:cont, {students_status_list ++ [ss], student_ids ++ [ss["student_id"]]}}
      else
        {:halt, {:error, "There are some errors in the request parameters, Please check."}}
      end
    end)
  end

  defp mark_attendance_based_on_status(date, student_ids, students_status) do
    existing_attendance_query = get_attendance_by_date_and_student_ids(date, student_ids)

    existing_student_ids =
      from(a in existing_attendance_query, select: a.student_id) |> Repo.all()

    {create_attrs, student_ids_with_forenoon_absent, student_ids_with_afternoon_absent,
     absent_student_ids,
     present_student_ids} =
      students_status
      |> Enum.reduce({[], [], [], [], []}, fn ss,
                                              {create_attrs, student_ids_with_forenoon_absent,
                                               student_ids_with_afternoon_absent,
                                               absent_student_ids, present_student_ids} ->
        cond do
          ss["student_id"] not in existing_student_ids and
              not (ss["forenoon_status"] == Constants.Attendance.present() and
                       ss["afternoon_status"] == Constants.Attendance.present()) ->
            {create_attrs ++
               [
                 %{
                   student_id: ss["student_id"],
                   date: date,
                   forenoon_status: ss["forenoon_status"],
                   afternoon_status: ss["afternoon_status"],
                   inserted_at:
                     DateTime.utc_now() |> DateTime.truncate(:second) |> DateTime.to_naive(),
                   updated_at:
                     DateTime.utc_now() |> DateTime.truncate(:second) |> DateTime.to_naive()
                 }
               ], student_ids_with_forenoon_absent, student_ids_with_afternoon_absent,
             absent_student_ids, present_student_ids}

          ss["student_id"] in existing_student_ids and
            ss["forenoon_status"] == Constants.Attendance.absent() and
              ss["afternoon_status"] == Constants.Attendance.present() ->
            {create_attrs, student_ids_with_forenoon_absent ++ [ss["student_id"]],
             student_ids_with_afternoon_absent, absent_student_ids, present_student_ids}

          ss["student_id"] in existing_student_ids and
            ss["forenoon_status"] == Constants.Attendance.present() and
              ss["afternoon_status"] == Constants.Attendance.absent() ->
            {create_attrs, student_ids_with_forenoon_absent,
             student_ids_with_afternoon_absent ++ [ss["student_id"]], absent_student_ids,
             present_student_ids}

          ss["student_id"] in existing_student_ids and
            ss["forenoon_status"] == Constants.Attendance.absent() and
              ss["afternoon_status"] == Constants.Attendance.absent() ->
            {create_attrs, student_ids_with_forenoon_absent, student_ids_with_afternoon_absent,
             absent_student_ids ++ [ss["student_id"]], present_student_ids}

          ss["student_id"] in existing_student_ids and
            ss["forenoon_status"] == Constants.Attendance.present() and
              ss["afternoon_status"] == Constants.Attendance.present() ->
            {create_attrs, student_ids_with_forenoon_absent, student_ids_with_afternoon_absent,
             absent_student_ids, present_student_ids ++ [ss["student_id"]]}

          true ->
            {create_attrs, student_ids_with_forenoon_absent, student_ids_with_afternoon_absent,
             absent_student_ids, present_student_ids}
        end
      end)

    Multi.new()
    |> Multi.insert_all(:insert_attendances, Attendance, fn _ -> create_attrs end)
    |> Multi.update_all(
      :update_attendances_with_forenoon_absent,
      from(a in existing_attendance_query,
        where: a.student_id in ^student_ids_with_forenoon_absent
      ),
      set: [
        forenoon_status: Constants.Attendance.absent(),
        afternoon_status: Constants.Attendance.present()
      ]
    )
    |> Multi.update_all(
      :update_attendances_with_afternoon_absent,
      from(a in existing_attendance_query,
        where: a.student_id in ^student_ids_with_afternoon_absent
      ),
      set: [
        forenoon_status: Constants.Attendance.present(),
        afternoon_status: Constants.Attendance.absent()
      ]
    )
    |> Multi.update_all(
      :update_attendances_with_absent,
      from(a in existing_attendance_query,
        where: a.student_id in ^absent_student_ids
      ),
      set: [
        forenoon_status: Constants.Attendance.absent(),
        afternoon_status: Constants.Attendance.absent()
      ]
    )
    |> Multi.delete_all(
      :delete_attendances_with_present,
      from(a in existing_attendance_query,
        where: a.student_id in ^present_student_ids
      )
    )
    |> Repo.transaction()
    |> case do
      {:ok, _result} ->
        {:ok, student_ids}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def create_attendance(attrs) do
    %Attendance{}
    |> Attendance.changeset(attrs)
    |> Repo.insert()
  end

  def update_attendance(%Attendance{} = attendance, attrs) do
    attendance
    |> Attendance.changeset(attrs)
    |> Repo.update()
  end
end
