defmodule SchoolManagement.ClassTest do
  use SchoolManagement.DataCase

  alias SchoolManagement.Class

  describe "schools" do
    alias SchoolManagement.Class.School

    import SchoolManagement.ClassFixtures

    @invalid_attrs %{
      address: nil,
      city: nil,
      email: nil,
      name: nil,
      phone_number: nil,
      postal_code: nil,
      registration_number: nil,
      state: nil
    }

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Class.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Class.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      valid_attrs = %{
        address: "some address",
        city: "some city",
        email: "some email",
        name: "some name",
        phone_number: 42,
        postal_code: 42,
        registration_number: "some registration_number",
        state: "some state"
      }

      assert {:ok, %School{} = school} = Class.create_school(valid_attrs)
      assert school.address == "some address"
      assert school.city == "some city"
      assert school.email == "some email"
      assert school.name == "some name"
      assert school.phone_number == 42
      assert school.postal_code == 42
      assert school.registration_number == "some registration_number"
      assert school.state == "some state"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Class.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()

      update_attrs = %{
        address: "some updated address",
        city: "some updated city",
        email: "some updated email",
        name: "some updated name",
        phone_number: 43,
        postal_code: 43,
        registration_number: "some updated registration_number",
        state: "some updated state"
      }

      assert {:ok, %School{} = school} = Class.update_school(school, update_attrs)
      assert school.address == "some updated address"
      assert school.city == "some updated city"
      assert school.email == "some updated email"
      assert school.name == "some updated name"
      assert school.phone_number == 43
      assert school.postal_code == 43
      assert school.registration_number == "some updated registration_number"
      assert school.state == "some updated state"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Class.update_school(school, @invalid_attrs)
      assert school == Class.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Class.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Class.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Class.change_school(school)
    end
  end
end
