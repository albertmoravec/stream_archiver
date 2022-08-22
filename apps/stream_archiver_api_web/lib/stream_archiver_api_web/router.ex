defmodule StreamArchiverApiWeb.Router do
  use StreamArchiverApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StreamArchiverApiWeb do
    pipe_through :api

    resources "/streams", StreamController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end
end
