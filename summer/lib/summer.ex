defmodule Summer do
  use GenServer

  alias Summer.Counter

  # client API

  def start_link(input_string) do
    GenServer.start_link(__MODULE__, input_string, name: :summer)
  end

  def inc(pid \\ :summer) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid \\ :summer) do
    GenServer.cast(pid, :dec)
  end

  def show(pid \\ :summer) do
    GenServer.call(pid, :show)
  end

  def inc_and_show(pid \\ :summer) do
    GenServer.call(pid, :inc_and_show)
  end

  # server callbacks

  def init(input_string) do
    {:ok, Counter.new(input_string)}
  end

  def handle_cast(:inc, counter) do
    {:noreply, Counter.inc(counter)}
  end

  def handle_cast(:dec, counter) do
    {:noreply, Counter.dec(counter)}
  end

  def handle_call(:show, _from, counter) do
    {:reply, Counter.show(counter), counter}
  end

  def handle_call(:inc_and_show, _from, counter) do
    new_counter = Counter.inc(counter)
    {:reply, Counter.show(new_counter), new_counter}
  end
end
