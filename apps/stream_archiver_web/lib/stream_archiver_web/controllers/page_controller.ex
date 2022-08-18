defmodule StreamArchiverWeb.PageController do
  use StreamArchiverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
