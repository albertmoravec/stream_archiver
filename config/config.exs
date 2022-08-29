import Config

# Configure Mix tasks and generators
config :stream_archiver,
  output_module: StreamArchiver.Recordings.Output.File,
  file_output: [
    storage_path: "./"
  ],
  ecto_repos: [StreamArchiver.Repo]

config :stream_archiver, Oban,
  repo: StreamArchiver.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [
    default: 10,
    recording: [
      limit: 10
    ]
  ]

# Configures the mailer
config :stream_archiver, StreamArchiver.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :stream_archiver_web,
  ecto_repos: [StreamArchiver.Repo],
  generators: [context_app: :stream_archiver]

# Configures the endpoint
config :stream_archiver_web, StreamArchiverWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: StreamArchiverWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: StreamArchiver.PubSub,
  live_view: [signing_salt: "GgO+OeBY"]

config :stream_archiver_api_web,
  ecto_repos: [StreamArchiver.Repo],
  generators: [context_app: :stream_archiver]

# Configures the endpoint
config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: StreamArchiverApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: StreamArchiver.PubSub,
  live_view: [signing_salt: "3XtxBfbp"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/stream_archiver_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :twitch_api,
  openid_client: :twitch,
  token_lifetime: 3600

config :twitch_api, :openid_connect_providers,
  twitch: [
    discovery_document_uri: "https://id.twitch.tv/oauth2/.well-known/openid-configuration",
    response_type: "code",
    scope: "openid email profile offline_access"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# Import local configuration overrides which are not part of the repository
File.regular?("config/.local.exs") && import_config(".local.exs")
