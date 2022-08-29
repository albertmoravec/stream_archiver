import Config

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :stream_archiver, StreamArchiver.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5"),
    socket_options: maybe_ipv6

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("API_PORT") || "4001")
    ],
    secret_key_base: secret_key_base

  config :stream_archiver_web, StreamArchiverWeb.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("WEB_PORT") || "4000")
    ],
    secret_key_base: secret_key_base

  if System.get_env("WEB_SERVER") do
    config :stream_archiver_web, StreamArchiverWeb.Endpoint, server: true
  end

  if System.get_env("API_SERVER") do
    config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint, server: true
  end
end
