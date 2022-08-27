defmodule StreamArchiver.Recordings.Output do
  @callback save_output(output_stream :: Stream.default(), file_name :: binary) :: :ok | {:error, term}

  def save_output(output_stream, file_name) do
    with {:ok, module} <- current_output() do
      module.save_output(output_stream, file_name)
    end
  end

  defp current_output() do
    case Application.fetch_env(:stream_archiver, :output_module) do
      :error -> {:error, :output_not_set}
      {:ok, module} -> {:ok, module}
    end
  end
end
