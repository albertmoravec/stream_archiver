defmodule StreamArchiver.Streams.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  alias StreamArchiver.Streams.StreamTag
  alias StreamArchiver.Tags.Tag

  schema "streams" do
    field :name, :string
    field :broadcaster_user_id, :string

    many_to_many :tags, Tag, join_through: StreamTag

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:name, :broadcaster_user_id])
    |> validate_required([:name, :broadcaster_user_id])
    |> unique_constraint(:name)
    |> unique_constraint(:broadcaster_user_id)
  end
end
