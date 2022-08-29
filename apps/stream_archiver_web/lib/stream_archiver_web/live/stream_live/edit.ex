defmodule StreamArchiverWeb.StreamLive.Edit do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Streams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _url, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Edit Stream")
     |> assign(:stream, Streams.get_stream!(id))}
  end
end
