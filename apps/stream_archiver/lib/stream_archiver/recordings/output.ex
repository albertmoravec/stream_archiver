defmodule StreamArchiver.Recordings.Output do
  @callback create_output(name :: binary) :: {:ok, Stream.default()} | {:error, term}

  def create_output(name) do
    with {:ok, module} <- current_output() do
      module.create_output(name)
    end
  end

  defp current_output() do
    case Application.fetch_env(:stream_archiver, :output_module) do
      :error -> {:error, :output_not_set}
      output -> output
    end
  end
end
