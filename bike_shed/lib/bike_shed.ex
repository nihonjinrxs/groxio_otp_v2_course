defmodule BikeShed do
  use GenServer
  alias BikeShed.Core

  # Client

  def start_link(input \\ "") do
    GenServer.start_link(__MODULE__, input, name: :shed)
  end
  
  def show(history_id \\ :shed) do
    GenServer.call(history_id, :show)
    |> IO.puts()
  end
  
  def add(history_id \\ :shed, item) do
    GenServer.cast(history_id, {:add, item})
  end

  # Callbacks

  def init(input) do
    {:ok, Core.new(input)}
  end

  def handle_call(:show, _from, history) do
    {:reply, Core.show(history), history}
  end

  def handle_cast({:add, item}, history) do
    {:noreply, Core.add(history, item)}
  end
end
