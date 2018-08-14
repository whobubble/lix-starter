defmodule EngineInterfaceWeb.CounterChannel do
  use EngineInterfaceWeb, :channel

  alias Engine.{Counter, CounterSupervisor}

  def join("counter:" <> _player, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("hello", payload, socket) do
    broadcast!(socket, "said_hello", payload)
    {:noreply, socket}
  end

  def handle_in("new_counter", _payload, socket) do
    "counter:" <> name = socket.topic

    case CounterSupervisor.start_counter(name, 0) do
      {:ok, _pid} ->
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{reason: inspect(reason)}}, socket}
    end
  end
end
