defmodule StreamArchiver.Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def change do
    create table(:recordings) do
      add :stream_id, references(:streams, on_delete: :nothing)

      timestamps()
    end

    create index(:recordings, [:stream_id])
  end
end
