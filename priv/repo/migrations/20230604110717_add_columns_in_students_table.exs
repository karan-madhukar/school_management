defmodule SchoolManagement.Repo.Migrations.AddColumnsInStudentsTable do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :date_of_joining, :date
      add :date_of_leaving, :date
    end
  end
end
