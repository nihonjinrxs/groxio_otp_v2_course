defmodule Brother do
  use GenServer

  # client API

  def start_link({name, _character_quote}=arg) do
    GenServer.start_link(__MODULE__, arg, name: name)
  end

  # server callbacks
  
  def init({name, _character_quote}=arg) do
    IO.puts "Starting #{name}..."
    {:ok, arg}
  end

  def child_spec([]), do: child_spec {:julia, "Coffee... that's the stuff!"}
  def child_spec({name, _character_quote}=arg) do
    %{
      id: name,
      start: {__MODULE__, :start_link, [arg]}
    }
  end
end
