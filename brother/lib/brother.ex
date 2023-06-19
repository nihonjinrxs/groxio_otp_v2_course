defmodule Brother do
  use GenServer

  # client API

  def start_link({name, _character_quote}=arg) do
    GenServer.start_link(__MODULE__, arg, name: name)
  end

  def start_child(arg) do
    DynamicSupervisor.start_child(__MODULE__.DynamicSupervisor, {__MODULE__, arg})
  end

  # server callbacks
  
  def init({name, _character_quote}=arg) do
    IO.puts "Starting #{name}..."
    {:ok, arg}
  end

  def child_spec({name, _character_quote}=arg \\ {:julia, "Coffee... that's the stuff!"}) do
    %{
      id: name,
      start: {__MODULE__, :start_link, [arg]}
    }
  end
end
