defmodule BookshelfTest do
  use ExUnit.Case
  doctest Bookshelf

  test "greets the world" do
    assert Bookshelf.hello() == :world
  end
end
