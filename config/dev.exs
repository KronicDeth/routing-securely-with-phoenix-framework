use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
dev_http_port = 4000
prod_http_port = 80
prod_https_port = 443
dev_https_port = dev_http_port - prod_http_port + prod_https_port

config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  force_ssl: [port: dev_https_port],
  http: [port: dev_http_port],
  https: [port: dev_https_port],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :routing_securely_with_phoenix_framework, RoutingSecurelyWithPhoenixFramework.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
