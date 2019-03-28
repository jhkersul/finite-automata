defmodule TapeTest do
  use ExUnit.Case
  doctest Tape

  test "should create a tape" do
    assert Tape.init(["$", "h", "e"], ["l", "l", "o", "$"]) ==
      %{
        left: ["$", "h", "e"],
        right: ["l", "l", "o", "$"]
      }
  end

  test "should get character at cell" do
    tape = Tape.init(["$", "h"], ["o", "$"])
    assert Tape.at(tape) == "o"
  end

  test "should move the cell one to the right" do
    tape = Tape.init(["$", "h"], ["l", "o", "$"])
    assert Tape.reconfig(tape) == 
      %{
        left: ["$", "h", "l"],
        right: ["o", "$"]
      }
  end

  test "should return the content of a tape" do
    tape = Tape.init(["$", "h"], ["l", "o", "$"])

    Tape.contents(tape) == tape
  end
end
