defmodule StreamArchiver.Recordings.Output.S3 do
  alias ExAws.S3

  def create_output(name) do
    path = Path.join(storage_path!(), name)
    file_stream = S3.Upload.stream_file(path)

    result =
      file_stream
      |> S3.upload(bucket!(), path)
      |> ExAws.request()

    case result do
      {:ok, _} -> file_stream
      _ -> raise "Error opening S3 output stream"
    end
  end

  defp bucket!() do
    Application.fetch_env!(:stream_archiver, :s3_output)
    |> Keyword.fetch!(:bucket)
  end

  defp storage_path!() do
    Application.fetch_env!(:stream_archiver, :file_output)
    |> Keyword.fetch!(:storage_path)
  end
end
