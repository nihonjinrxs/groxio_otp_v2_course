defmodule BikeShed.Core do
  @max_length 3

  def new(input) do
    input
    |> String.split(",", trim: true)
  end

  def add(history, item) do
    [item | history]
    |> Enum.take(@max_length)
  end

  def show(history) do
    history
    |> Enum.join("\n")
  end
end