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
        name: %Schema{type: :string, description: "Stream name"},
        broadcaster_user_id: %Schema{type: :string, description: "Broadcaster ID"},
        eventsub_id: %Schema{type: :string, description: "EventSub ID"}
      },
      example: %{
        "id" => 1,
        "name" => "arptryx",
        "broadcaster_user_id" => "695513849",
        "eventsub_id" => "4595322f-0bc6-45a8-b3c0-7dad229b8a14"
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
          %{"id" => 1, "name" => "arptryx", "broadcaster_user_id" => "695513849", "eventsub_id" => "4595322f-0bc6-45a8-b3c0-7dad229b8a14"},
          %{"id" => 2, "name" => "char_dj", "broadcaster_user_id" => "195739322", "eventsub_id" => "af5930dd-1234-5678-0900-7dd135677884"}
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
