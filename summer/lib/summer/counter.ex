defmodule Summer.Counter do
  defstruct [:count]

  # construct
  def new(input_string) do
    %__MODULE__{
      count: String.to_integer(input_string),
    }
  end

  # reduce
  def inc(%{count: count}=counter) do
    %{counter | count: count + 1 }
  end
  def dec(%{count: count}=counter) do
    %{counter | count: count - 1 }
  end

  # convert
  def show(%{count: count}) do
    "The count is #{count}"
  end
end
