defmodule StreamArchiver.Streams.Webhooks do
  alias TwitchApi.EventSub

  import StreamArchiver.Streams
  import StreamArchiver.Config

  def handle_stream_online(data) do
    data["event"]["broadcaster_user_id"]
    |> get_stream_by_broadcaster_id()
    |> start_recording()
  end

  def subscribe_stream_online(broadcaster_id) do
    EventSub.subscribe(%{
      "type" => "stream.online",
      "version" => "1",
      "condition" => %{
        "broadcaster_user_id" => broadcaster_id,
      },
      "transport" => %{
        "method" => "webhook",
        "callback" => "https://4252-78-45-23-114.eu.ngrok.io/webhooks/stream-online",
        "secret" => webhook_secret!()
      }
    })
  end
end
