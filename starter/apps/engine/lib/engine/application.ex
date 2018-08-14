defmodule Engine.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Registry.Counter},
      Engine.CounterSupervisor
    ]

    :ets.new(:counter_state, [:public, :named_table])

    opts = [strategy: :one_for_one, name: Engine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
