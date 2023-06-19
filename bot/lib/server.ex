# counter, GenServer
defmodule Bot.Server do
  use GenServer
  
  alias Bot.Counter

  # client API

  def start_link(input) do
    GenServer.start_link(__MODULE__, input, name: :counter)
  end

  def inc(pid \\ :counter), do: GenServer.cast(pid, :inc)
  def dec(pid \\ :counter), do: GenServer.cast(pid, :dec)
  def show(pid \\ :counter), do: GenServer.call(pid, :show)

  # server-side callbacks

  def init(input), do: {:ok, Counter.new(input)}
  def handle_cast(:inc, counter), do: {:noreply, Counter.add(counter, 1)}
  def handle_cast(:dec, counter), do: {:noreply, Counter.add(counter, -1)}
  def handle_call(:show, _, counter), do: {:reply, Counter.show(counter), counter}
end
