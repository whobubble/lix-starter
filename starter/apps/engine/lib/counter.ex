defmodule Counter do
  defstruct [:count]
  def new(initial), do: %Counter{count: initial}
  def inc(%Counter{} = counter), do: update_in(counter.count, fn count -> count + 1 end)
end
