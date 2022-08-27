defmodule StreamArchiverApiWeb.Router do
  use StreamArchiverApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: StreamArchiverApiWeb.ApiSpec
  end

  scope "/" do
    pipe_through :api

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/", StreamArchiverApiWeb do
    pipe_through :api

    scope "/streams" do
      resources "/", StreamController, except: [:new, :edit]

      post "/:id/start-recording", StreamController, :start_recording
    end

    resources "/tags", TagController, except: [:new, :edit]
  end
end
