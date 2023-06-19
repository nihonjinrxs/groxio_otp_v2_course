defmodule RandyTest do
  use ExUnit.Case
  doctest Randy

  test "greets the world" do
    assert Randy.hello() == :world
  end
end
