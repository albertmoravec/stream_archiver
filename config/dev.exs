import Config

# Configure your database
config :stream_archiver, StreamArchiver.Repo,
  username: "stream_archiver_dev",
  password: "stream_archiver_dev",
  hostname: "localhost",
  database: "stream_archiver_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :stream_archiver_web, StreamArchiverWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "LnhMcxFLhCSpYV/IP9h9/bUlI8tXjEJ9d2YUtYRJrXIf3KBribhhrgk8oHOC5K/p",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

# Watch static and templates for browser reloading.
config :stream_archiver_web, StreamArchiverWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/stream_archiver_web/(live|views)/.*(ex)$",
      ~r"lib/stream_archiver_web/templates/.*(eex)$"
    ]
  ]

config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "LnhMcxFLhCSpYV/IP9h9/bUlI8tXjEJ9d2YUtYRJrXIf3KBribhhrgk8oHOC5K/p",
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :open_api_spex, :cache_adapter, OpenApiSpex.Plug.NoneCache

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20
