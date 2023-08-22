defmodule SchoolManagement.Students.Student do
  @moduledoc """
  Student module
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SchoolManagement.Schools.{Class, School, Section}

  @email_regex ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  schema "students" do
    field :address, :string
    field :date_of_birth, :date
    field :email, :string
    field :name, :string
    field :phone_number, :string
    field :registration_number, :string
    field :date_of_joining, :date
    field :date_of_leaving, :date

    belongs_to :school, School
    belongs_to :class, Class
    belongs_to :section, Section

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [
      :name,
      :registration_number,
      :address,
      :date_of_birth,
      :phone_number,
      :email,
      :school_id,
      :class_id,
      :section_id
    ])
    |> validate_required([
      :name,
      :registration_number,
      :address,
      :date_of_birth,
      :phone_number,
      :email,
      :school_id,
      :class_id,
      :section_id
    ])
    |> validate_format(:email, @email_regex)
    |> foreign_key_constraint(:school_id)
    |> foreign_key_constraint(:class_id)
    |> foreign_key_constraint(:section_id)
    |> unique_constraint(:email)
    |> unique_constraint(:registration_number)
  end
end
