defmodule Engine.CounterSupervisor do
  use Supervisor

  alias Engine.Counter

  def start_link(_options), do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: Supervisor.init([Counter], strategy: :simple_one_for_one)

  def start_counter(name, initial), do: Supervisor.start_child(__MODULE__, [name, initial])

  def stop_counter(name) do
    :ets.delete(:counter_state, name)
    Supervisor.terminate_child(__MODULE__, pid_for_counter(name))
  end

  defp pid_for_counter(name) do
    Counter.via_tuple(name)
    |> GenServer.whereis()
  end
end
