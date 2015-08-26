# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  force_ssl: [hsts: true],
  https: [certfile: "priv/tls/server-#{Mix.env}.crt",
          keyfile: "priv/tls/server-#{Mix.env}.key",
          # Allow for relative path for certfile and keyfile
          otp_app: :routing_securely_with_phoenix_framework],
  pubsub: [name: RoutingSecurelyWithPhoenixFramework.PubSub,
           adapter: Phoenix.PubSub.PG2],
  render_errors: [default_format: "html"],
  root: Path.dirname(__DIR__),
  url: [host: "#{Mix.env}.routing-securely-with-phoenix-framework.localhost"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "#{Mix.env}.secret.exs"
