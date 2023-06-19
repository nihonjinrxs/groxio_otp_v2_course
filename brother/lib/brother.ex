defmodule Brother do
  use GenServer

  # client API

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: :big_bro)
  end

  # server callbacks
  
  def init(arg) do
    IO.puts "Starting..."
    {:ok, arg}
  end
end
