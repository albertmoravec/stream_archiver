defmodule StreamArchiverWeb.WebhookController do
  alias StreamArchiver.Streams.Webhooks

  use StreamArchiverWeb, :controller

  def stream_online(conn, params) do
    subscription_type = eventsub_subscription_type(conn)
    message_type = eventsub_message_type(conn)

    case subscription_type do
      "stream.online" -> handle_stream_online(message_type, conn, params)
      _ -> {:error, :invalid_subscription_type}
    end
  end

  defp handle_stream_online(:verification, conn, params) do
    send_resp(conn, :ok, params["challenge"])
  end

  defp handle_stream_online(:notification, conn, params) do
    IO.inspect(conn.req_headers, label: "Stream online headers")
    IO.inspect(params, label: "Stream online params")

    with :ok <- Webhooks.handle_stream_online(params["event"]["broadcaster_user_id"], params["subscription"]["id"]) do
      send_resp(conn, :ok, "")
    end
  end

  defp handle_stream_online(:revocation, conn, _params) do
    send_resp(conn, :ok, "")
  end

  defp eventsub_message_type(conn) do
    conn
    |> header_value("twitch-eventsub-message-type")
    |> message_type_to_atom()
  end

  defp eventsub_subscription_type(conn) do
    conn
    |> header_value("twitch-eventsub-subscription-type")
  end

  defp message_type_to_atom(message_type) do
    case message_type do
      "webhook_callback_verification" -> :verification
      "notification" -> :notification
      "revocation" -> :revocation
      _ -> nil
    end
  end

  defp header_value(conn, key) do
    conn.req_headers
    |> Enum.find({nil, nil}, fn {name, _} -> name == key end)
    |> elem(1)
  end

  # TODO webhook verification https://dev.twitch.tv/docs/eventsub/handling-webhook-events/#responding-to-a-challenge-request

  # TODO handle webhook revocation https://dev.twitch.tv/docs/eventsub/handling-webhook-events/#responding-to-a-challenge-request
end
