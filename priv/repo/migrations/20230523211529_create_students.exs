defmodule SchoolManagement.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string, null: false
      add :date_of_birth, :date, null: false
      add :address, :string, null: false
      add :registration_number, :string, null: false
      add :phone_number, :string
      add :email, :string, null: false
      add :class_id, references(:classes), null: false
      add :school_id, references(:schools), null: false

      timestamps()
    end

    create unique_index(:students, [:registration_number])
    create unique_index(:students, [:email])
  end
end
