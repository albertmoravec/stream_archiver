defmodule StreamArchiver.Repo do
  use Ecto.Repo,
    otp_app: :stream_archiver,
    adapter: Ecto.Adapters.Postgres
end
