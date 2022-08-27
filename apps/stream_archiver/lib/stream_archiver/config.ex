defmodule StreamArchiver.Config do
  def user_token!() do
    Application.fetch_env!(:stream_archiver, :twitch_user_token)
  end
end
