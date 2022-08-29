defmodule StreamArchiver.Recordings.Worker do
  import StreamArchiver.Config
  import StreamArchiver.Recordings.Output
  import StreamArchiver.Recordings

  require Logger

  use Oban.Worker,
    queue: :recording,
    unique: [
      fields: [:args],
      keys: [:stream_id],
      period: :infinity,
      states: [:available, :scheduled, :executing, :retryable]
    ]

  # @impl Oban.Worker
  # def backoff(%Oban.Job{attempt: _attempt}) do
  #   # 1 second backoff
  #   1
  # end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => stream_id, "name" => stream_name}}) do
    Logger.debug("Recording worker called for stream #{stream_id}: #{stream_name}")

    file_name = stream_file_name(stream_name)

    with {:ok, recording} <- create_recording(%{stream_id: stream_id, file_name: file_name}) do
      record_stream(stream_name, recording.file_name)
    end
  end

  def record_stream(stream_name, file_name) do
    Logger.debug("#{stream_name} recording started to #{file_name}")

    raw_stream =
      ExCmd.stream!([
        "streamlink",
        "--stdout",
        "--twitch-api-header=Authentication=OAuth #{user_token!()}",
        "twitch.tv/#{stream_name}",
        "audio_only"
      ])

    audio_stream =
      ExCmd.stream!(["ffmpeg", "-i", "pipe:0", "-map", "0:a", "-c", "copy", "-f", "adts", "-"],
        input: raw_stream
      )

    save_output(audio_stream, file_name)
  end

  def stream_file_name(stream_name) do
    datetime = DateTime.utc_now()
    datetime_str = Calendar.strftime(datetime, "%Y-%m-%d_%H-%M")

    "#{stream_name}_#{datetime_str}.aac"
  end
end
