use Mix.Config

config :engine_interface, EngineInterfaceWeb.Endpoint,
  load_from_system_env: true,
  # http: [port: {:system, "PORT"}], # Uncomment this line if you are running Phoenix 1.2
  # Without this line, your app will not start the web server!
  server: true,
  secret_key_base: "oCu2cZMKj4g5/S7AILBlLhSSiXMR5yMGEO/fGmGbHoq1X3uDa1JUGRoHQaS0Tn1w",
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

# config :engine_interface, EngineInterfaceWeb.Endpoint,
#   load_from_system_env: true,
#   url: [host: "example.com", port: 80],
#   cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info
