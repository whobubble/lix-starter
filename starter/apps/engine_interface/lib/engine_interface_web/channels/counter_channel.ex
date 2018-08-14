defmodule EngineInterfaceWeb.CounterChannel do
  use EngineInterfaceWeb, :channel

  alias Engine.{Counter, CounterSupervisor}

  def join("counter:" <> _player, _payload, socket) do
    {:ok, socket}
  end
end
