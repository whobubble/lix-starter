# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :engine_interface,
  namespace: EngineInterface

# Configures the endpoint
config :engine_interface, EngineInterfaceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cai3kWC9BfstQW6xbu0o7bDMSRsQvZfazHc9TonmuoxqOqULKlAtA9Wfp6SG5Eyp",
  render_errors: [view: EngineInterfaceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EngineInterface.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
