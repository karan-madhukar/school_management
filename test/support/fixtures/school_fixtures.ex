defmodule SchoolManagement.SchoolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SchoolManagement.School` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SchoolManagement.School.create_class()

    class
  end

  @doc """
  Generate a section.
  """
  def section_fixture(attrs \\ %{}) do
    {:ok, section} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SchoolManagement.School.create_section()

    section
  end
end
