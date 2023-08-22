defmodule SchoolManagement.Repo do
  use Ecto.Repo,
    otp_app: :school_management,
    adapter: Ecto.Adapters.Postgres
end
