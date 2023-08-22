defmodule SchoolManagementWeb.StudentView do
  use SchoolManagementWeb, :view

  def render("index.json", %{students: students}) do
    %{
      data: render_many(students, __MODULE__, "student.json"),
      meta: nil
    }
  end

  def render("student.json", %{student: student}) do
    %{
      id: student.id,
      type: "student",
      name: student.name,
      address: student.address,
      date_of_birth: student.date_of_birth,
      email: student.email,
      registration_number: student.registration_number,
      phone_number: student.phone_number
    }
  end
end
