defmodule SchoolManagementWeb.AttendanceController do
  use SchoolManagementWeb, :controller

  alias SchoolManagement.Students

  def create_or_update(
        conn,
        %{
          "students_status" => _students_status,
          "date" => _date,
          "school_id" => _school_id,
          "class_id" => _class_id,
          "section_id" => _section_id
        } = params
      ) do
    case Students.create_or_update_attendances(params) do
      {:ok, student_ids} ->
        render(conn, student_ids: student_ids, message: "Attendance Marked Successfully!")

      {:error, reason} ->
        unprocessable_entity(conn, reason)
    end
  end

  defp unprocessable_entity(conn, reason) do
    conn
    |> put_status(422)
    |> put_view(SchoolManagementWeb.ErrorView)
    |> json(%{error: reason})
  end
end
