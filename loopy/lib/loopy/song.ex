defmodule Loopy.Song do
  @behaviour Loopy

  def go do
    Loopy.run(__MODULE__)
  end

  @impl true
  def work do
    IO.puts(
      """
      Louie, Louie,
      Oh no, we gotta go
      yeah yeah yeah yeah


      """
    )
  end

  @impl true
  def wait do
    Process.sleep(300)
  end
end
