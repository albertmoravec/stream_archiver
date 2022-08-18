defmodule StreamArchiver.Repo.Migrations.CreateStreams do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :name, :string

      timestamps()
    end

    create unique_index(:streams, [:name])
  end
end
