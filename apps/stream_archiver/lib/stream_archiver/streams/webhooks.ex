defmodule StreamArchiver.Streams.Webhooks do
  alias HTTPoison.Response
  alias TwitchApi.EventSub

  import StreamArchiver.Streams
  import StreamArchiver.Config

  def handle_stream_online(broadcaster_id, eventsub_id) do
    case get_stream_by_broadcaster_id(broadcaster_id) do
      nil -> {:error, :stream_not_found}
      stream when stream.eventsub_id != eventsub_id -> {:error, :invalid_eventsub_id}
      stream -> start_recording(stream)
    end
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
        "callback" => webhook_base_url!() <> "/webhooks/stream-online",
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

  def unsubscribe_stream_online(eventsub_id) do
    with {:ok, %Response{status_code: 204}} <- EventSub.unsubscribe(id: eventsub_id) do
      {:ok, :unsubscribed}
    else
      {:ok, %Response{} = response} -> {:error, response}
    end
  end
end
