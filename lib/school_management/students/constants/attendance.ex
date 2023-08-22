defmodule SchoolManagement.Students.Constants.Attendance do
  @moduledoc """
  Defines all attendance constants.
  """

  ####################
  #  BASE CONSTANTS  #
  ####################

  def absent(), do: "ABSENT"

  def present(), do: "PRESENT"

  #######################
  #  DERIVED CONSTANTS  #
  #######################

  def statuses() do
    [
      absent(),
      present()
    ]
  end
end
