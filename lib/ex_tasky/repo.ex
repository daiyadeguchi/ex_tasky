defmodule ExTasky.Repo do
  use Ecto.Repo,
    otp_app: :ex_tasky,
    adapter: Ecto.Adapters.Postgres
end
