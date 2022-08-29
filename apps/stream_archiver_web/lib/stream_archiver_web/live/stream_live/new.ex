defmodule StreamArchiverWeb.StreamLive.New do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Streams.Stream

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "New Stream")
     |> assign(:stream, %Stream{})}
  end
end
