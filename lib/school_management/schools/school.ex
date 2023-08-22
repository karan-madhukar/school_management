defmodule SchoolManagement.Schools.School do
  @moduledoc """
  School module
  """
  use Ecto.Schema
  import Ecto.Changeset

  @phone_regex ~r/\A([1-9])\d{9}\Z/i
  @email_regex ~r/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  schema "schools" do
    field :address, :string
    field :city, :string
    field :email, :string
    field :name, :string
    field :phone_number, :string
    field :postal_code, :integer
    field :registration_number, :string
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [
      :name,
      :registration_number,
      :address,
      :city,
      :state,
      :postal_code,
      :phone_number,
      :email
    ])
    |> validate_required([
      :name,
      :registration_number,
      :address,
      :city,
      :state,
      :postal_code,
      :phone_number,
      :email
    ])
    |> validate_format(:email, @email_regex)
    |> validate_format(:email, @phone_regex)
    |> unique_constraint(:email)
    |> unique_constraint(:registration_number)
  end
end
