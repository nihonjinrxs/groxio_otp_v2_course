defmodule Cauldron do
  use GenServer

  @short 200
  @long  400

  def toil_and_trouble(server) do
    short_wait()
    toil(server)
    IO.puts "MQlen = #{message_queue_length(server)}"
    toil_and_trouble(server)
  end
  
  def toil(server) do
    # Using cast results in a backup of message queue
    # GenServer.cast(server, :toil)
    # Using call makes this blocking, applying some backpressure on the queue
    :ok = GenServer.call(server, :toil)
  end

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @impl true
  def init(initial_value) do
    {:ok, initial_value}
  end

  @impl true
  def handle_cast(:toil, state) do
    long_job()
    {:noreply, state + 1}
  end

  @impl true
  def handle_call(:toil, _from, state) do
    long_job()
    {:reply, :ok, state + 1}
  end

  defp message_queue_length(pid) do
    pid
    |> Process.info(:message_queue_len)
    |> elem(1)
  end

  defp short_wait(), do: wait(@short)

  defp long_job(), do: wait(@long)

  defp wait(time) do
    time
    |> :rand.uniform()
    |> Process.sleep()
  end
end
