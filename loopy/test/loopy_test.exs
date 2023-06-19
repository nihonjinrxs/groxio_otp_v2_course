defmodule LoopyTest do
  use ExUnit.Case
  doctest Loopy

  test "greets the world" do
    assert Loopy.hello() == :world
  end
end
