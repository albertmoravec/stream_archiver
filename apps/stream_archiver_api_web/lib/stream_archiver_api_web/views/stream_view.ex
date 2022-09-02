defmodule StreamArchiverApiWeb.StreamView do
  use StreamArchiverApiWeb, :view
  alias StreamArchiverApiWeb.StreamView

  def render("index.json", %{streams: streams}) do
    %{data: render_many(streams, StreamView, "stream.json")}
  end

  def render("show.json", %{stream: stream}) do
    %{data: render_one(stream, StreamView, "stream.json")}
  end

  def render("stream.json", %{stream: stream}) do
    %{
      id: stream.id,
      name: stream.name,
      broadcaster_user_id: stream.broadcaster_user_id,
      eventsub_id: stream.eventsub_id
    }
  end
end
