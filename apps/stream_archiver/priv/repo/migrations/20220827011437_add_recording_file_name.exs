defmodule StreamArchiver.Repo.Migrations.AddRecordingFileName do
  use Ecto.Migration

  def change do
    alter table(:recordings) do
      add :file_name, :string
    end
  end
end
