defmodule StreamArchiver.Repo.Migrations.AddStreamEventsubId do
  use Ecto.Migration

  def change do
    alter table(:streams) do
      add :eventsub_id, :string
    end

    create unique_index(:streams, [:eventsub_id])
  end
end
