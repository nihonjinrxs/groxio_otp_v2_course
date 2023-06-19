defmodule Loopy.BackSeat do
  @behaviour Loopy

  def go do
    Loopy.run(__MODULE__)
  end

  @impl true
  def work do
    IO.puts(
      [
        "Ow!",
        "Quit it",
        "Are we there yet?",
        "I'm hungry",
        "I have to pee",
      ]
      |> Enum.map(fn s -> s <> "\n\n" end)
      |> Enum.random()
      |> IO.puts()
    )
  end

  @impl true
  def wait do
    5_000 |> :rand.uniform() |> Process.sleep()
  end
end
