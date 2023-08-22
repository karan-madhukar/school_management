defmodule SchoolManagement.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:classes, [:name])
  end
end
