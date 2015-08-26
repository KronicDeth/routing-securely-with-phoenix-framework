use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
test_http_port = 4001
prod_http_port = 80
prod_https_port = 443
test_https_port = test_http_port - prod_http_port + prod_https_port

config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  force_ssl: [port: test_https_port],
  http: [port: test_http_port],
  https: [port: test_https_port],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
