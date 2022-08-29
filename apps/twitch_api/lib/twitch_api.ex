defmodule TwitchApi do
  @moduledoc """
  Documentation for `TwitchApi`.
  """

  alias TwitchApi.Client

  @doc """
  Hello world.

  ## Examples

      iex> TwitchApi.hello()
      :world

  """
  def users(params \\ []) do
    Client.get("/users", [], params: params)
  end
end
