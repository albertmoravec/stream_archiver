defmodule StreamArchiverWeb.RecordingLive.Index do
  use StreamArchiverWeb, :live_view

  alias StreamArchiver.Recordings
  alias StreamArchiver.Recordings.Recording

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :recordings, list_recordings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Recording")
    |> assign(:recording, Recordings.get_recording!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Recording")
    |> assign(:recording, %Recording{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Recordings")
    |> assign(:recording, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    recording = Recordings.get_recording!(id)
    {:ok, _} = Recordings.delete_recording(recording)

    {:noreply, assign(socket, :recordings, list_recordings())}
  end

  defp list_recordings do
    Recordings.list_recordings()
  end
end
