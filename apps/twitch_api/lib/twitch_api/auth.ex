defmodule TwitchApi.Auth do
  use Agent

  require Logger

  # seconds
  @expiration_margin 10

  def start_link(_initial) do
    Agent.start_link(fn -> :empty end, name: __MODULE__)
  end

  def get_service_token() do
    Agent.get_and_update(__MODULE__, &process_get/1)
  end

  defp process_get({access_token, expiration} = data) do
    if token_valid(expiration) do
      Logger.debug("Token valid, returning current token with expiration: #{expiration}")

      {{:ok, access_token}, data}
    else
      Logger.debug("Token expired")

      process_get(:empty)
    end
  end

  defp process_get(:empty) do
    case retrieve_service_token() do
      {:ok, access_token, expiration} ->
        Logger.debug("Successfully retrieved new Twitch API token")

        data = {access_token, :os.system_time(:seconds) + expiration}

        {{:ok, access_token}, data}

      error ->
        Logger.error("Couldn't retrieve new service token, error: #{inspect(error)}")
        {{:error, :no_service_token}, :empty}
    end
  end

  def token_valid(expiration) do
    expiration - @expiration_margin >= :os.system_time(:seconds)
  end

  defp retrieve_service_token() do
    auth_client = Application.get_env(:twitch_api, :openid_client)

    case OpenIDConnect.fetch_tokens(auth_client, %{
           grant_type: "client_credentials"
           #  scope: "https://graph.microsoft.com/.default"
         }) do
      {:ok, %{"access_token" => access_token, "expires_in" => expiration}} ->
        {:ok, access_token, expiration}

      error ->
        error
    end
  end
end
