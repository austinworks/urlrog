defmodule Urlrog.Repo do
  use Ecto.Repo,
    otp_app: :urlrog,
    adapter: Ecto.Adapters.Postgres
end
