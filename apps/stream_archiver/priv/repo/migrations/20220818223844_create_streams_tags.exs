defmodule StreamArchiver.Repo.Migrations.CreateStreamsTags do
  use Ecto.Migration

  def change do
    create table(:streams_tags) do
      add :stream_id, references(:streams, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end

    create index(:streams_tags, [:stream_id])
    create index(:streams_tags, [:tag_id])
  end
end
