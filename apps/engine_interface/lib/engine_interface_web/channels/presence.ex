defmodule EngineInterfaceWeb.Presence do
  @moduledoc false

  use Phoenix.Presence, otp_app: :engine_interface, pubsub_server: EngineInterface.PubSub
end
