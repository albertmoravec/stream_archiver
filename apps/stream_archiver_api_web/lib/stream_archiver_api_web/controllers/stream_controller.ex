defmodule StreamArchiverApiWeb.StreamController do
  use StreamArchiverApiWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias OpenApiSpex.Reference

  alias StreamArchiver.Streams
  alias StreamArchiver.Streams.Stream

  alias StreamArchiverApiWeb.Schemas.Stream.StreamCreateRequest
  alias StreamArchiverApiWeb.Schemas.Stream.StreamUpdateRequest
  alias StreamArchiverApiWeb.Schemas.Stream.StreamResponse
  alias StreamArchiverApiWeb.Schemas.Stream.StreamsResponse

  action_fallback StreamArchiverApiWeb.FallbackController

  tags ["streams"]

  operation :index,
    summary: "List streams",
    responses: [
      ok: {"Stream listing", "application/json", StreamsResponse}
    ]

  def index(conn, _params) do
    streams = Streams.list_streams()
    render(conn, "index.json", streams: streams)
  end

  operation :create,
    summary: "Register new stream",
    request_body: {
      "Stream create request body",
      "application/json",
      StreamCreateRequest,
      required: true
    },
    responses: [
      created: {"Stream response", "application/json", StreamResponse}
    ]

  def create(conn, %{"stream" => stream_params}) do
    with {:ok, %Stream{} = stream} <- Streams.create_stream(stream_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.stream_path(conn, :show, stream))
      |> render("show.json", stream: stream)
    end
  end

  operation :show,
    summary: "Show detailed stream information",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Stream/properties/id"},
        description: "Stream ID",
        example: 1,
        required: true
      ]
    ],
    responses: [
      ok: {"Stream response", "application/json", StreamResponse}
    ]

  def show(conn, %{"id" => id}) do
    stream = Streams.get_stream!(id)
    render(conn, "show.json", stream: stream)
  end

  operation :update,
    summary: "Update stream information",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Stream/properties/id"},
        description: "Stream ID",
        example: 1,
        required: true
      ]
    ],
    request_body: {
      "Stream update request body",
      "application/json",
      StreamUpdateRequest,
      required: true
    },
    responses: [
      ok: {"Stream response", "application/json", StreamResponse}
    ]

  def update(conn, %{"id" => id, "stream" => stream_params}) do
    stream = Streams.get_stream!(id)

    with {:ok, %Stream{} = stream} <- Streams.update_stream(stream, stream_params) do
      render(conn, "show.json", stream: stream)
    end
  end

  operation :delete,
    summary: "Delete stream",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Stream/properties/id"},
        description: "Stream ID",
        example: 1,
        required: true
      ]
    ],
    responses: [
      no_content: {"Stream deleted sucessfully", nil, nil}
    ]

  def delete(conn, %{"id" => id}) do
    stream = Streams.get_stream!(id)

    with {:ok, %Stream{}} <- Streams.delete_stream(stream) do
      send_resp(conn, :no_content, "")
    end
  end

  def start_recording(conn, %{"id" => id}) do
    Streams.get_stream!(id)
    |> Streams.start_recording()

    send_resp(conn, :ok, "")
  end
end
