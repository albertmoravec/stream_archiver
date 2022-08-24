defmodule StreamArchiverWeb.RecordingLive.Show do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Recordings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:recording, Recordings.get_recording!(id))}
  end

  defp page_title(:show), do: "Show Recording"
  defp page_title(:edit), do: "Edit Recording"
end
