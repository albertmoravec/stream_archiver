defmodule TwitchApi.Client do
  alias TwitchApi.Config

  use HTTPoison.Base

  @endpoint "https://api.twitch.tv/helix"

  def process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    # TODO Replace token with this https://dev.twitch.tv/docs/authentication/getting-tokens-oauth/#client-credentials-grant-flow

    headers
    |> Keyword.put(:"Authorization", "Bearer " <> Config.authorization_token!())
    |> Keyword.put(:"Client-Id", Config.client_id!())
  end
end
