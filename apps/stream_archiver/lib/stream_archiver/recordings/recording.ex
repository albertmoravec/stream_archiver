defmodule StreamArchiver.Recordings.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do
    field :stream_id, :id
    field :file_name, :string

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:stream_id, :file_name])
    |> validate_required([:stream_id, :file_name])
  end
end
