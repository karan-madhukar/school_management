defmodule SchoolManagement.Repo.Migrations.CreateAttendances do
  use Ecto.Migration

  def change do
    create table(:attendances) do
      add :student_id, references(:students), null: false
      add :date, :date, null: false
      add :forenoon_status, :string, default: "ABSENT"
      add :afternoon_status, :string, default: "ABSENT"

      timestamps()
    end

    create unique_index(:attendances, [:student_id, :date])
  end
end
