defmodule SchoolManagement.SchoolsTest do
  use SchoolManagement.DataCase

  alias SchoolManagement.Schools

  describe "class_sections" do
    alias SchoolManagement.Schools.ClassSection

    import SchoolManagement.SchoolsFixtures

    @invalid_attrs %{}

    test "list_class_sections/0 returns all class_sections" do
      class_section = class_section_fixture()
      assert Schools.list_class_sections() == [class_section]
    end

    test "get_class_section!/1 returns the class_section with given id" do
      class_section = class_section_fixture()
      assert Schools.get_class_section!(class_section.id) == class_section
    end

    test "create_class_section/1 with valid data creates a class_section" do
      valid_attrs = %{}

      assert {:ok, %ClassSection{} = class_section} = Schools.create_class_section(valid_attrs)
    end

    test "create_class_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schools.create_class_section(@invalid_attrs)
    end

    test "update_class_section/2 with valid data updates the class_section" do
      class_section = class_section_fixture()
      update_attrs = %{}

      assert {:ok, %ClassSection{} = class_section} =
               Schools.update_class_section(class_section, update_attrs)
    end

    test "update_class_section/2 with invalid data returns error changeset" do
      class_section = class_section_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Schools.update_class_section(class_section, @invalid_attrs)

      assert class_section == Schools.get_class_section!(class_section.id)
    end

    test "delete_class_section/1 deletes the class_section" do
      class_section = class_section_fixture()
      assert {:ok, %ClassSection{}} = Schools.delete_class_section(class_section)
      assert_raise Ecto.NoResultsError, fn -> Schools.get_class_section!(class_section.id) end
    end

    test "change_class_section/1 returns a class_section changeset" do
      class_section = class_section_fixture()
      assert %Ecto.Changeset{} = Schools.change_class_section(class_section)
    end
  end
end
