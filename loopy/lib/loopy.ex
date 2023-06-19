defmodule Loopy do
  @callback work() :: :ok
  @callback wait() :: :ok

  def run(module) do
    spawn(fn -> loop(module) end)
  end

  def loop(module) do
    module
    |> work()
    |> loop()
  end
  
  def work(module) do
    module.wait()
    module.work()
    module
  end
end
