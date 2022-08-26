defmodule StreamArchiver.Config do
  def user_token!() do
    Application.fetch_env!(:stream_archiver, :user_token)
  end
end
