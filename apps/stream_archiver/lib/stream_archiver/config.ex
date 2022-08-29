defmodule StreamArchiver.Config do
  def user_token!() do
    Application.fetch_env!(:stream_archiver, :twitch_user_token)
  end

  def webhook_secret!() do
    Application.fetch_env!(:stream_archiver, :twitch_webhook_secret)
  end

  def webhook_base_url!() do
    Application.fetch_env!(:stream_archiver, :webhook_base_url)
  end
end
