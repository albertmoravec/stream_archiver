defmodule StreamArchiver.Streams.StreamTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streams_tags" do

    field :stream_id, :id
    field :tag_id, :id

    timestamps()
  end

  @doc false
  def changeset(stream_tag, attrs) do
    stream_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
