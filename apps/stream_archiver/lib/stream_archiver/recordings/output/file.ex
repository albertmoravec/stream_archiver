defmodule StreamArchiver.Recordings.Output.File do
  require Logger

  @behaviour StreamArchiver.Recordings.Output

  @impl true
  def save_output(output_stream, file_name) do
    Logger.debug("Stream save to file was requested")

    path = Path.join(storage_path!(), file_name)

    output_stream
    |> Stream.into(File.stream!(path))
    |> Stream.run()

    :ok
  end

  defp storage_path!() do
    Application.fetch_env!(:stream_archiver, :file_output)
    |> Keyword.fetch!(:storage_path)
  end
end
