defmodule StreamArchiver.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias StreamArchiver.Streams.Stream
  alias StreamArchiver.Streams.StreamTag

  schema "tags" do
    field :name, :string
    many_to_many :streams, Stream, join_through: StreamTag

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
