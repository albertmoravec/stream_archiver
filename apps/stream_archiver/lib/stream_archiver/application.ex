defmodule StreamArchiver.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      StreamArchiver.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: StreamArchiver.PubSub},
      # Start Oban job runner
      {Oban, Application.fetch_env!(:stream_archiver, Oban)}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: StreamArchiver.Supervisor)
  end
end
