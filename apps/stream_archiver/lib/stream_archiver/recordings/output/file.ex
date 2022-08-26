defmodule StreamArchiver.Recordings.Output.File do
  require Logger

  def create_output(name) do
    path = Path.join(storage_path!(), name)
    Logger.debug("Creating stream file output: #{path}")

    {:ok, File.stream!(path)}
  end

  defp storage_path!() do
    Application.fetch_env!(:stream_archiver, :file_output)
    |> Keyword.fetch!(:storage_path)
  end
end
