# counter service using only Elixir primitives
defmodule Bot.Service do
  alias Bot.Counter

  # client API

  def start(input) do
    spawn(fn -> loop(Counter.new(input)) end)
  end

  def inc(pid), do: send(pid, :inc)
  def dec(pid), do: send(pid, :dec)
  
  def show(pid) do
    send(pid, {:show, self()})
    receive do
      m -> m
    end
  end

  # server-side implementation

  def loop(counter) do
    counter
    |> listen()
    |> loop()
  end

  def listen(counter) do
    receive do
      :inc ->
        Counter.add(counter, 1)
      :dec ->
        Counter.add(counter, -1)
      {:show, from_pid} ->
        result = Counter.show(counter)
        send(from_pid, result)
        counter
    end
  end
end
