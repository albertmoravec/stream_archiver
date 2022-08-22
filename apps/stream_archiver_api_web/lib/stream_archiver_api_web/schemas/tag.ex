defmodule StreamArchiverApiWeb.Schemas.Tag do
  require OpenApiSpex

  alias OpenApiSpex.Schema
  alias OpenApiSpex.Reference

  defmodule TagSchema do
    OpenApiSpex.schema(%{
      title: "Tag",
      description: "Tag definition",
      type: :object,
      required: [:name],
      properties: %{
        id: %Schema{type: :integer, readOnly: true, description: "Tag ID"},
        name: %Schema{type: :string, description: "Tag name"}
      },
      example: %{
        "id" => 1,
        "name" => "House"
      }
    })
  end

  defmodule TagsResponse do
    OpenApiSpex.schema(%{
      title: "TagsResponse",
      description: "Tag listing definition",
      type: :object,
      properties: %{
        data: %Schema{type: :array, items: TagSchema}
      },
      example: %{
        "data" => [
          %{"id" => 1, "name" => "House"},
          %{"id" => 2, "name" => "Trance"}
        ]
      }
    })
  end

  defmodule TagCreateRequest do
    OpenApiSpex.schema(%{
      title: "TagCreateRequest",
      description: "Request schema for new tag",
      type: :object,
      properties: %{
        tag: TagSchema
      },
      example: %{
        "tag" => %{
          id: 1,
          name: "House"
        }
      }
    })
  end

  defmodule TagUpdateRequest do
    OpenApiSpex.schema(%{
      title: "TagUpdateRequest",
      description: "Request schema for new tag",
      type: :object,
      properties: %{
        id: %Reference{"$ref": "#/components/schemas/Tag/properties/id"},
        tag: TagSchema
      }
    })
  end

  defmodule TagResponse do
    OpenApiSpex.schema(%{
      title: "TagResponse",
      description: "Response schema for single tag",
      type: :object,
      properties: %{
        data: TagSchema
      }
    })
  end
end
