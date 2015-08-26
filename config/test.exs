use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  https: [port: 4364],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
