import Config

config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint

config :stream_archiver_web, StreamArchiverWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info
