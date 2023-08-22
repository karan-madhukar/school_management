defmodule SchoolManagementWeb.AttendanceView do
  use SchoolManagementWeb, :view

  def render("create_or_update.json", %{student_ids: student_ids, message: message}) do
    %{
      data: %{student_ids: student_ids},
      meta: %{message: message, message_type: "SUCCESS"}
    }
  end
end
