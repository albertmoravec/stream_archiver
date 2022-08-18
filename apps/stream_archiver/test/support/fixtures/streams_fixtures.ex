defmodule StreamArchiver.StreamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StreamArchiver.Streams` context.
  """

  @doc """
  Generate a unique stream name.
  """
  def unique_stream_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a stream.
  """
  def stream_fixture(attrs \\ %{}) do
    {:ok, stream} =
      attrs
      |> Enum.into(%{
        name: unique_stream_name()
      })
      |> StreamArchiver.Streams.create_stream()

    stream
  end
end
