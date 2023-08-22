defmodule SchoolManagementWeb.StudentController do
  use SchoolManagementWeb, :controller

  alias SchoolManagement.Students

  def index(
        conn,
        %{
          "school_id" => school_id,
          "class_id" => class_id,
          "section_id" => section_id
        }
      ) do
    students = Students.list_students_by_school_class_and_section(school_id, class_id, section_id)
    render(conn, students: students)
  end
end
