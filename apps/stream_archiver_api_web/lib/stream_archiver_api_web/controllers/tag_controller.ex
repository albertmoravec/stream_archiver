defmodule StreamArchiverApiWeb.TagController do
  use StreamArchiverApiWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias OpenApiSpex.Reference

  alias StreamArchiver.Tags
  alias StreamArchiver.Tags.Tag

  alias StreamArchiverApiWeb.Schemas.Tag.TagSchema
  alias StreamArchiverApiWeb.Schemas.Tag.TagCreateRequest
  alias StreamArchiverApiWeb.Schemas.Tag.TagUpdateRequest
  alias StreamArchiverApiWeb.Schemas.Tag.TagResponse
  alias StreamArchiverApiWeb.Schemas.Tag.TagsResponse

  action_fallback StreamArchiverApiWeb.FallbackController

  tags ["tags"]

  operation :index,
    summary: "List tags",
    responses: [
      ok: {"Tag listing", "application/json", TagsResponse}
    ]

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.json", tags: tags)
  end

  operation :create,
    summary: "Register new tag",
    request_body: {
      "Tag create request body",
      "application/json",
      TagCreateRequest,
      required: true
    },
    responses: [
      created: {"Tag response", "application/json", TagResponse}
    ]

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Tags.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  operation :show,
    summary: "Show detailed tag information",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Tag/properties/id"},
        description: "Tag ID",
        example: 1,
        required: true
      ]
    ],
    responses: [
      ok: {"Tag response", "application/json", TagResponse}
    ]

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  operation :update,
    summary: "Update tag information",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Tag/properties/id"},
        description: "Tag ID",
        example: 1,
        required: true
      ]
    ],
    request_body: {
      "Tag update request body",
      "application/json",
      TagUpdateRequest,
      required: true
    },
    responses: [
      ok: {"Tag response", "application/json", TagResponse}
    ]

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  operation :delete,
    summary: "Delete tag",
    parameters: [
      id: [
        in: :path,
        type: %Reference{"$ref": "#/components/schemas/Tag/properties/id"},
        description: "Tag ID",
        example: 1,
        required: true
      ]
    ],
    responses: [
      no_content: {"Tag deleted sucessfully", nil, nil}
    ]

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
