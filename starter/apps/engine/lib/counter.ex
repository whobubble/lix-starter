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

  def terminate({:shutdown, :timeout}, state_data) do
    :ets.delete(:counter_state, state_data.name)
    :ok
  end

  def terminate(_reason, _state), do: :ok

  def inc(counter), do: GenServer.call(counter, :inc)

  def dec(counter), do: GenServer.call(counter, :dec)

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

  def handle_call(:inc, _from, state) do
    new_state = update_in(state.count, fn c -> c + 1 end)
    reply_success(new_state, :ok)
  end

  def handle_call(:dec, _from, state = %{count: 0, name: _name}), do: reply_success(state, :ok)

  def handle_call(:dec, _from, state) do
    new_state = update_in(state.count, fn c -> c - 1 end)
    reply_success(new_state, :ok)
  end

  def handle_call(:get, _from, state), do: reply_success(state, :ok)

  def reply_success(state_data, reply) do
    :ets.insert(:counter_state, {state_data.name, state_data})
    {:reply, reply, state_data, @timeout}
  end

  defp fresh_state(name, initial), do: %{name: name, count: initial}
end
