import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stream_archiver_api_web, StreamArchiverApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UAtl8KcTT5T8B4YWu6wcZdQjMD446tG2IXmPAY38PlG7muvp2Brh5ttpRvlY5pLS",
  server: false

# Only in tests, remove the complexity from the password hashing algorithm
config :argon2_elixir, t_cost: 1, m_cost: 8

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :stream_archiver, StreamArchiver.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "stream_archiver_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stream_archiver_web, StreamArchiverWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Vynzt62otsdygsuREai52aCaT8COGfWr2L2h2+UtTBqOloBbFtO5SbQomjP7Vp6G",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :stream_archiver, StreamArchiver.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
