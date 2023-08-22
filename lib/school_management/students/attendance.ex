defmodule SchoolManagement.Students.Attendance do
  @moduledoc """
  Attendance module
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SchoolManagement.Students.{Constants.Attendance, Student}

  @absent Attendance.absent()
  @statuses Attendance.statuses()

  schema "attendances" do
    field :date, :date
    field :forenoon_status, :string, default: @absent
    field :afternoon_status, :string, default: @absent

    belongs_to :student, Student

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [
      :date,
      :forenoon_status,
      :afternoon_status,
      :student_id
    ])
    |> validate_required([
      :date,
      :forenoon_status,
      :afternoon_status,
      :student_id
    ])
    |> validate_date()
    |> validate_inclusion(:forenoon_status, @statuses)
    |> validate_inclusion(:afternoon_status, @statuses)
    |> foreign_key_constraint(:class_id)
    |> foreign_key_constraint(:student_id)
    |> unique_constraint([:student_id, :date])
  end

  defp validate_date(%Ecto.Changeset{valid?: false} = changeset), do: changeset

  defp validate_date(%Ecto.Changeset{} = changeset) do
    changeset
    |> get_field(:date)
    |> case do
      %Date{} = date ->
        day_diff = Timex.diff(date, Date.utc_today(), :day)

        if day_diff < 1 do
          changeset
        else
          add_error(changeset, :date, "Date should not be in future")
        end

      _ ->
        changeset
    end
  end
end
