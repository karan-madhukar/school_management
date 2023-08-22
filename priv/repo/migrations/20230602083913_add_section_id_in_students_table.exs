defmodule SchoolManagement.Repo.Migrations.AddSectionIdInStudentsTable do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :section_id, references(:sections), null: false
    end
  end
end
