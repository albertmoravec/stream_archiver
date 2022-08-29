defmodule StreamArchiver.Streams.Webhooks do
  alias HTTPoison.Response
  alias TwitchApi.EventSub

  import StreamArchiver.Streams
  import StreamArchiver.Config

  def handle_stream_online(broadcaster_id) do
    broadcaster_id
    |> get_stream_by_broadcaster_id()
    |> start_recording()
  end

  def subscribe_stream_online(broadcaster_id) do
    body = %{
      "type" => "stream.online",
      "version" => "1",
      "condition" => %{
        "broadcaster_user_id" => broadcaster_id
      },
      "transport" => %{
        "method" => "webhook",
        "callback" => "https://4252-78-45-23-114.eu.ngrok.io/webhooks/stream-online",
        "secret" => webhook_secret!()
      }
    }

    with {:ok, %Response{status_code: 202, body: %{"data" => [%{"id" => subscription_id} | _]}}} <-
           EventSub.subscribe(body) do
      {:ok, subscription_id}
    else
      {:ok, %Response{} = response} -> {:error, response}
      error -> error
    end
  end

  def unsubscribe_stream_online(broadcaster_id) do
    # FIXME this is abomination

    with {:ok, %Response{status_code: 200, body: %{"data" => data}}} <- EventSub.list(user_id: broadcaster_id) do
      case data do
        [%{"id" => subscription_id} | _] ->
          with {:ok, %Response{status_code: 204}} <- EventSub.unsubscribe(id: subscription_id) do
            {:ok, :unsubscribed}
          else
            {:ok, %Response{} = response} -> {:error, response}
          end

        [] ->
          {:ok, :no_subscription}

        _ ->
          {:error, :invalid_data}
      end
    else
      {:ok, %Response{} = response} -> {:error, response}
      error -> error
    end
  end
end
