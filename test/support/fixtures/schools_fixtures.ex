defmodule SchoolManagement.SchoolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SchoolManagement.Schools` context.
  """

  @doc """
  Generate a class_section.
  """
  def class_section_fixture(attrs \\ %{}) do
    {:ok, class_section} =
      attrs
      |> Enum.into(%{})
      |> SchoolManagement.Schools.create_class_section()

    class_section
  end
end
