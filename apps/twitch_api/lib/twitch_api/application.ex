defmodule TwitchApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {OpenIDConnect.Worker, Application.get_env(:twitch_api, :openid_connect_providers)},
      TwitchApi.Auth
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwitchApi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
