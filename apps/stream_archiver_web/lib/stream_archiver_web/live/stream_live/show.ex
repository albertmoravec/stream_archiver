defmodule StreamArchiverWeb.StreamLive.Show do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Streams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show Stream")
     |> assign(:stream, Streams.get_stream!(id))}
  end
end
