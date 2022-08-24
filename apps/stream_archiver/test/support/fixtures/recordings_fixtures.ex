defmodule StreamArchiver.RecordingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StreamArchiver.Recordings` context.
  """

  @doc """
  Generate a recording.
  """
  def recording_fixture(attrs \\ %{}) do
    {:ok, recording} =
      attrs
      |> Enum.into(%{

      })
      |> StreamArchiver.Recordings.create_recording()

    recording
  end
end
