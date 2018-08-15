use Mix.Config

config :engine_interface, EngineInterfaceWeb.Endpoint,
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

# config :engine_interface, EngineInterfaceWeb.Endpoint,
#   load_from_system_env: true,
#   url: [host: "example.com", port: 80],
#   cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info
