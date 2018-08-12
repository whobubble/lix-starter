defmodule Engine.CounterSupervisor do
  use Supervisor

  alias Engine.Counter

  def start_link(_options), do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: Supervisor.init([Counter], strategy: :simple_one_for_one)

  def start_counter(initial), do: Supervisor.start_child(__MODULE__, [initial])

  def stop_counter() do
    Supervisor.terminate_child(__MODULE__, pid_for_counter())
  end

  defp pid_for_counter() do
    Counter.via_tuple()
    |> GenServer.whereis()
  end
end
