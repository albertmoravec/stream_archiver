defmodule StreamArchiverWeb.WebhookController do
  import StreamArchiver.Streams.Webhooks

  use StreamArchiverWeb, :controller

  def stream_online(conn, params) do
    # TODO verify message signature header

    IO.inspect(params, label: "webhook params")

    handle_stream_online(params)

    send_resp(conn, :ok, "")
  end
end
