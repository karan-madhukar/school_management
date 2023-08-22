defmodule SchoolManagement.ClassFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SchoolManagement.Class` context.
  """

  @doc """
  Generate a school.
  """
  def school_fixture(attrs \\ %{}) do
    {:ok, school} =
      attrs
      |> Enum.into(%{
        address: "some address",
        city: "some city",
        email: "some email",
        name: "some name",
        phone_number: 42,
        postal_code: 42,
        registration_number: "some registration_number",
        state: "some state"
      })
      |> SchoolManagement.Class.create_school()

    school
  end
end
