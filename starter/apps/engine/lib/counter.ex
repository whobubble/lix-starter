defmodule Engine.Counter do
  use GenServer, start: {__MODULE__, :start_link, []}, restart: :transient

  @timeout 15000

  def via_tuple(), do: {:via, Registry, {Registry.Counter, "counter"}}

  def start_link(initial) when is_integer(initial) and initial >= 0,
    do: GenServer.start_link(__MODULE__, initial, name: via_tuple())

  def init(initial), do: {:ok, initial, @timeout}

  def inc(counter), do: GenServer.cast(counter, :inc)

  def dec(counter), do: GenServer.cast(counter, :dec)

  def get(counter), do: GenServer.call(counter, :get)

  def handle_cast(:inc, state), do: {:noreply, state + 1}

  def handle_cast(:dec, 0), do: {:noreply, 0}
  def handle_cast(:dec, state), do: {:noreply, state - 1}

  def handle_call(:get, _from, state), do: {:reply, state, state}
end
