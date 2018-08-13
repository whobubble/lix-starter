defmodule Engine.Counter do
  use GenServer, start: {__MODULE__, :start_link, []}, restart: :transient

  @timeout 60 * 60 * 24 * 1000

  def via_tuple(name), do: {:via, Registry, {Registry.Counter, name}}

  def start_link(name, initial) when is_binary(name) and is_integer(initial) and initial >= 0,
    do: GenServer.start_link(__MODULE__, %{count: initial, name: name}, name: via_tuple(name))

  def init(initial_state), do: {:ok, initial_state, @timeout}

  def inc(counter), do: GenServer.cast(counter, :inc)

  def dec(counter), do: GenServer.cast(counter, :dec)

  def get(counter), do: GenServer.call(counter, :get)

  def handle_info(:timeout, state) do
    {:stop, {:shutdown, :timeout}, state}
  end

  def handle_cast(:inc, state), do: {:noreply, update_in(state.count, fn c -> c + 1 end)}

  def handle_cast(:dec, 0), do: {:noreply, 0}
  def handle_cast(:dec, state), do: {:noreply, update_in(state.count, fn c -> c - 1 end)}

  def handle_call(:get, _from, state), do: {:reply, state.count, state}
end
