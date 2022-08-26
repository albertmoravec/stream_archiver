defmodule StreamArchiver.Repo.Migrations.AddStreamBroadcasterUserId do
  use Ecto.Migration

  def change do
    alter table(:streams) do
      add :broadcaster_user_id, :string
    end

    create unique_index(:streams, [:broadcaster_user_id])
  end
end
