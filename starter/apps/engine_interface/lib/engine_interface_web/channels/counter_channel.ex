defmodule EngineInterfaceWeb.CounterChannel do
  use EngineInterfaceWeb, :channel

  alias Engine.{Counter, CounterSupervisor}
  alias EngineInterfaceWeb.Presence

  def join("counter:" <> _player, %{"screen_name" => screen_name}, socket) do
    send(self(), {:after_join, screen_name})
    {:ok, socket}
  end

  def handle_info({:after_join, name}, socket) do
    {:ok, _} = Presence.track(socket, name, %{online_at: inspect(System.system_time(:seconds))})
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

  def handle_in("inc", _payload, socket) do
    case Counter.inc(via(socket.topic)) do
      :ok ->
        broadcast!(socket, "counter_inc", %{message: "Counter increased"})
        {:noreply, socket}

      :error ->
        {:reply, :error, socket}
    end
  end

  def handle_in("dec", _payload, socket) do
    case Counter.dec(via(socket.topic)) do
      :ok ->
        broadcast!(socket, "counter_dec", %{message: "Counter decreased"})
        {:noreply, socket}

      :error ->
        {:reply, :error, socket}
    end
  end

  def handle_in("get", _payload, socket) do
    count = Counter.get(via(socket.topic))
    {:reply, {:ok, %{count: count}}, socket}
  end

  def handle_in("show_subscribers", _payload, socket) do
    broadcast!(socket, "subscribers", Presence.list(socket))
    {:noreply, socket}
  end

  defp via("counter:" <> name), do: Counter.via_tuple(name)
end
