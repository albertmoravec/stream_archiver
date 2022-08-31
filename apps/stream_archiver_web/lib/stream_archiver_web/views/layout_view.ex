defmodule StreamArchiverWeb.LayoutView do
  use StreamArchiverWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def gravatar_hash(email) do
    hash_input =
      email
      |> String.trim()
      |> String.downcase()

    :crypto.hash(:md5, hash_input)
    |> Base.encode16(case: :lower)
  end
end
