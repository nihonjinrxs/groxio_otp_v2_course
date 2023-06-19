defmodule BrotherTest do
  use ExUnit.Case
  doctest Brother

  test "greets the world" do
    assert Brother.hello() == :world
  end
end
