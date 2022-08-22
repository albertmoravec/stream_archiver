defmodule StreamArchiverApiWeb.Schemas.Stream do
  require OpenApiSpex

  alias OpenApiSpex.Schema
  alias OpenApiSpex.Reference

  defmodule StreamSchema do
    OpenApiSpex.schema(%{
      title: "Stream",
      description: "Stream definition",
      type: :object,
      required: [:name],
      properties: %{
        id: %Schema{type: :integer, readOnly: true, description: "Stream ID"},
        name: %Schema{type: :string, description: "Stream name"}
      },
      example: %{
        "id" => 1,
        "name" => "arptryx"
      }
    })
  end

  defmodule StreamsResponse do
    OpenApiSpex.schema(%{
      title: "StreamsResponse",
      description: "Stream listing definition",
      type: :object,
      properties: %{
        data: %Schema{type: :array, items: StreamSchema}
      },
      example: %{
        "data" => [
          %{"id" => 1, "name" => "arptryx"},
          %{"id" => 2, "name" => "char_dj"}
        ]
      }
    })
  end

  defmodule StreamCreateRequest do
    OpenApiSpex.schema(%{
      title: "StreamCreateRequest",
      description: "Request schema for new stream",
      type: :object,
      properties: %{
        stream: StreamSchema
      },
      example: %{
        "stream" => %{
          "name" => "arptryx"
        }
      }
    })
  end

  defmodule StreamUpdateRequest do
    OpenApiSpex.schema(%{
      title: "StreamUpdateRequest",
      description: "Request schema for new stream",
      type: :object,
      properties: %{
        id: %Reference{"$ref": "#/components/schemas/Stream/properties/id"},
        stream: StreamSchema
      },
      example: %{
        "id" => 1,
        "stream" => %{
          "name" => "char_dj"
        }
      }
    })
  end

  defmodule StreamResponse do
    OpenApiSpex.schema(%{
      title: "StreamResponse",
      description: "Response schema for single stream",
      type: :object,
      properties: %{
        data: StreamSchema
      }
    })
  end
end
