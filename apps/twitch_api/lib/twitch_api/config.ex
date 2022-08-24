defmodule TwitchApi.Config do
  def authorization_token!() do
    Application.fetch_env!(:twitch_api, :authorization_token)
  end

  def client_id!() do
    Application.fetch_env!(:twitch_api, :client_id)
  end
end
