defmodule StreamArchiver.Recordings.Worker do
  import StreamArchiver.Config
  import StreamArchiver.Recordings.Output

  use Oban.Worker

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"stream_name" => stream_name}}) do
    record_stream(stream_name)
  end

  def record_stream(stream_name) do
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

    save_output(audio_stream, stream_file_name(stream_name) <> ".aac")
  end

  def stream_file_name(stream_name) do
    datetime = DateTime.utc_now()
    datetime_str = Calendar.strftime(datetime, "%Y-%m-%d_%H-%M")

    "#{stream_name}_#{datetime_str}"
  end
end
