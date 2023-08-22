defmodule SchoolManagement.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :name, :string, null: false
      add :registration_number, :string, null: false
      add :address, :string, null: false
      add :city, :string, null: false
      add :state, :string, null: false
      add :postal_code, :integer, null: false
      add :phone_number, :string
      add :email, :string, null: false

      timestamps()
    end

    create unique_index(:schools, [:registration_number])
    create unique_index(:schools, [:email])
  end
end
