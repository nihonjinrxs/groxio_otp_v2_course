defmodule Rememberall do
  use GenServer

  # client

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: :mem)
  end

  def get(pid \\ :mem) do
    GenServer.call(pid, :get)
  end
  
  def set(pid \\ :mem, value) do
    GenServer.cast(pid, {:set, value})
  end
  
  def say(pid \\ :mem) do
    send(pid, :say)
  end

  # callbacks

  @impl true
  def init(initial_state) do
    new_state = initial_state
    {:ok, new_state}
  end

  # async (2-way) messaging with reply
  @impl true
  def handle_call(:get, _from, old_state) do
    new_state = old_state
    to_client = old_state
    {:reply, to_client, new_state}
  end

  # async (1-way) message with no response
  @impl true
  def handle_cast({:set, new_state}, _old_state) do
    {:noreply, new_state}
  end

  # async (1-way) message with no response
  # (old-style erlang message)
  @impl true
  def handle_info(:say, old_state) do
    IO.puts "The value is #{old_state}"
    new_state = old_state
    {:noreply, new_state}
  end
end
