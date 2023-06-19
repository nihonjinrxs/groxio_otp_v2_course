defmodule Brother do
  use GenServer

  # client API

  def start_link({name, _character_quote}=arg) do
    GenServer.start_link(__MODULE__, arg, name: via(name))
  end

  def via(name) do
    {:via, Registry, {Brother.Registry, name}}
  end

  def start_child(arg) do
    DynamicSupervisor.start_child(__MODULE__.DynamicSupervisor, {__MODULE__, arg})
  end

  def say(name) do
    GenServer.call(via(name), :say)
  end

  # server callbacks
  
  def init({name, _character_quote}=arg) do
    IO.puts "Starting #{name}..."
    {:ok, arg}
  end

  def handle_call(:say, _from, {_name, character_quote}=state) do
    {:reply, character_quote, state}
  end

  def child_spec({name, _character_quote}=arg \\ {:julia, "Coffee... that's the stuff!"}) do
    %{
      id: name,
      start: {__MODULE__, :start_link, [arg]}
    }
  end
end
