defmodule Engine.Counter do
  use GenServer, start: {__MODULE__, :start_link, []}, restart: :transient

  @timeout 60 * 60 * 24 * 1000

  def via_tuple(name), do: {:via, Registry, {Registry.Counter, name}}

  def start_link(name, initial_count)
      when is_binary(name) and is_integer(initial_count) and initial_count >= 0,
      do: GenServer.start_link(__MODULE__, {name, initial_count}, name: via_tuple(name))

  def init({name, count}) do
    send(self(), {:set_state, name, count})
    {:ok, fresh_state(name, count)}
  end

  def inc(counter), do: GenServer.cast(counter, :inc)

  def dec(counter), do: GenServer.cast(counter, :dec)

  def get(counter), do: GenServer.call(counter, :get)

  def handle_info(:timeout, state) do
    {:stop, {:shutdown, :timeout}, state}
  end

  def handle_info({:set_state, name, count}, _state_data) do
    state_data =
      case(:ets.lookup(:counter_state, name)) do
        [] -> fresh_state(name, count)
        [{_key, state}] -> state
      end

    :ets.insert(:counter_state, {name, state_data})

    {:noreply, state_data, @timeout}
  end

  def handle_cast(:inc, state), do: {:noreply, update_in(state.count, fn c -> c + 1 end)}

  def handle_cast(:dec, 0), do: {:noreply, 0}
  def handle_cast(:dec, state), do: {:noreply, update_in(state.count, fn c -> c - 1 end)}

  def handle_call(:get, _from, state), do: reply_success(state, state.count)

  def reply_success(state_data, reply) do
    :ets.insert(:counter_state, {state_data.name, state_data})
    {:reply, reply, state_data, @timeout}
  end

  defp fresh_state(name, initial), do: %{name: name, count: initial}
end
