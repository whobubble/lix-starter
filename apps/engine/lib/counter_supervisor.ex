defmodule Engine.CounterSupervisor do
  @moduledoc false

  use Supervisor

  alias Engine.Counter

  def start_link(_options), do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  @dialyzer {:no_fail_call, init: 1}
  @spec init(any()) :: no_return()
  def init(:ok), do: Supervisor.init([Counter], strategy: :simple_one_for_one)

  def start_counter(name, initial), do: Supervisor.start_child(__MODULE__, [name, initial])

  def stop_counter(name) do
    :ets.delete(:counter_state, name)
    Supervisor.terminate_child(__MODULE__, pid_for_counter(name))
  end

  defp pid_for_counter(name) do
    via = Counter.via_tuple(name)

    via
    |> GenServer.whereis()
  end
end
