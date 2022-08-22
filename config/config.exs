# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :stream_archiver_api_web,
  ecto_repos: [StreamArchiverApiWeb.Repo],
  generators: [context_app: :stream_archiver]

# Configures the endpoint
config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: StreamArchiverApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: StreamArchiverApiWeb.PubSub,
  live_view: [signing_salt: "3XtxBfbp"]

# Configure Mix tasks and generators
config :stream_archiver,
  ecto_repos: [StreamArchiver.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
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

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/stream_archiver_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
