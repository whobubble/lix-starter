defmodule EngineInterfaceWeb.Presence do
  use Phoenix.Presence, otp_app: :engine_interface, pubsub_server: EngineInterface.PubSub
end
