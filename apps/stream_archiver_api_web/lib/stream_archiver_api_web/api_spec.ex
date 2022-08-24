defmodule StreamArchiverApiWeb.ApiSpec do
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    web_server = Server.from_endpoint(StreamArchiverWeb.Endpoint)

    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        %{web_server | url: web_server.url <> "/api"},
        Server.from_endpoint(StreamArchiverApiWeb.Endpoint)
      ],
      info: %Info{
        title: "Stream Archiver",
        version: "0.0.1"
      },
      # Populate the paths from a phoenix router
      paths: Paths.from_router(StreamArchiverApiWeb.Router)
    }
    |> OpenApiSpex.resolve_schema_modules() # Discover request/response schemas from path specs
  end
end
