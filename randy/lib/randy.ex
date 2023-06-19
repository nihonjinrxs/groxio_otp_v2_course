defmodule Randy do
  use GenServer

  @impl true
  def init(max), do: {:ok, max}

  @impl true
  def handle_call(:roll, _from, max) do
    {:reply, :rand.uniform(max), max}
  end
end
