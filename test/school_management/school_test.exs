defmodule SchoolManagement.SchoolTest do
  use SchoolManagement.DataCase

  alias SchoolManagement.School

  describe "classes" do
    alias SchoolManagement.School.Class

    import SchoolManagement.SchoolFixtures

    @invalid_attrs %{name: nil}

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert School.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert School.get_class!(class.id) == class
    end

    test "create_class/1 with valid data creates a class" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Class{} = class} = School.create_class(valid_attrs)
      assert class.name == "some name"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Class{} = class} = School.update_class(class, update_attrs)
      assert class.name == "some updated name"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_class(class, @invalid_attrs)
      assert class == School.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = School.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> School.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = School.change_class(class)
    end
  end

  describe "sections" do
    alias SchoolManagement.School.Section

    import SchoolManagement.SchoolFixtures

    @invalid_attrs %{name: nil}

    test "list_sections/0 returns all sections" do
      section = section_fixture()
      assert School.list_sections() == [section]
    end

    test "get_section!/1 returns the section with given id" do
      section = section_fixture()
      assert School.get_section!(section.id) == section
    end

    test "create_section/1 with valid data creates a section" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Section{} = section} = School.create_section(valid_attrs)
      assert section.name == "some name"
    end

    test "create_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_section(@invalid_attrs)
    end

    test "update_section/2 with valid data updates the section" do
      section = section_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Section{} = section} = School.update_section(section, update_attrs)
      assert section.name == "some updated name"
    end

    test "update_section/2 with invalid data returns error changeset" do
      section = section_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_section(section, @invalid_attrs)
      assert section == School.get_section!(section.id)
    end

    test "delete_section/1 deletes the section" do
      section = section_fixture()
      assert {:ok, %Section{}} = School.delete_section(section)
      assert_raise Ecto.NoResultsError, fn -> School.get_section!(section.id) end
    end

    test "change_section/1 returns a section changeset" do
      section = section_fixture()
      assert %Ecto.Changeset{} = School.change_section(section)
    end
  end
end
