defmodule StreamArchiver.Streams.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  alias StreamArchiver.Streams.StreamTag
  alias StreamArchiver.Tags.Tag

  schema "streams" do
    field :name, :string
    many_to_many :tags, Tag, join_through: StreamTag

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
