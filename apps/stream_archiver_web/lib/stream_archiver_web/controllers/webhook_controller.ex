defmodule StreamArchiverWeb.WebhookController do
  alias StreamArchiver.Streams.Webhooks

  use StreamArchiverWeb, :controller

  def stream_online(conn, params) do
    message_type = eventsub_message_type(conn)

    # TODO handle errors
    handle_stream_online(message_type, conn, params)
  end

  defp handle_stream_online(:verification, conn, params) do
    send_resp(conn, :ok, params["challenge"])
  end

  defp handle_stream_online(:notification, conn, params) do
    with :ok <- Webhooks.handle_stream_online(params["event"]["broadcaster_user_id"]) do
      send_resp(conn, :ok, "")
    end
  end

  defp handle_stream_online(:revocation, conn, _params) do
    send_resp(conn, :ok, "")
  end

  defp eventsub_message_type(conn) do
    conn.req_headers
    |> Enum.find({nil, nil}, fn {name, _} -> name == "twitch-eventsub-message-type" end)
    |> elem(1)
    |> message_type_to_atom()
  end

  defp message_type_to_atom(message_type) do
    case message_type do
      "webhook_callback_verification" -> :verification
      "notification" -> :notification
      "revocation" -> :revocation
      _ -> nil
    end
  end

  # TODO webhook verification https://dev.twitch.tv/docs/eventsub/handling-webhook-events/#responding-to-a-challenge-request

  # TODO handle webhook revocation https://dev.twitch.tv/docs/eventsub/handling-webhook-events/#responding-to-a-challenge-request
end
