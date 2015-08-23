use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "routing_securely_with_phoenix_framework_test",
  pool: Ecto.Adapters.SQL.Sandbox
