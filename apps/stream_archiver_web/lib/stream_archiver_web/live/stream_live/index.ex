defmodule StreamArchiverWeb.StreamLive.Index do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Streams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :streams, list_streams())}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Listing Streams")}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stream = Streams.get_stream!(id)
    {:ok, _} = Streams.delete_stream(stream)

    {:noreply, assign(socket, :streams, list_streams())}
  end

  def handle_event("start_recording", %{"id" => id}, socket) do
    :ok =
      Streams.get_stream!(id)
      |> Streams.start_recording()

    {:noreply, socket}
  end

  defp list_streams do
    Streams.list_streams()
  end
end
