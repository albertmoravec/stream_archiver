defmodule TwitchApi.Client do
  alias TwitchApi.Config
  alias TwitchApi.Auth

  # TODO use Tesla?

  use HTTPoison.Base

  @endpoint "https://api.twitch.tv/helix"

  def process_url(url) do
    @endpoint <> url
  end

  def process_request_headers(headers) do
    # TODO error handling
    {:ok, token} = Auth.get_service_token()

    headers
    |> Keyword.put(:Authorization, "Bearer " <> token)
    |> Keyword.put(:"Client-Id", Config.client_id!())
    |> Keyword.put(:"Content-Type", "application/json")
  end

  def process_request_body(body) do
    case body do
      "" -> "{}"
      body -> Jason.encode!(body)
    end
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
