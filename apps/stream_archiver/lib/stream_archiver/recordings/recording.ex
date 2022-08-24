defmodule StreamArchiver.Recordings.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do

    field :stream_id, :id

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [])
    |> validate_required([])
  end
end
