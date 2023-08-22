defmodule SchoolManagement.Schools.Section do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sections" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(section, attrs) do
    section
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
