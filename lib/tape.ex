defmodule Tape do
  # Inits a new tape
  def init(left, right) do
    %{ left: left, right: right }
  end

  # Gets the value for the current cell on tape
  def at(tape) do
    List.first(tape.right)
  end

  # Reconfigs the tape, moving to the next cell
  def reconfig(tape) do
    { value, new_right } = List.pop_at(tape.right, 0)
    new_left = List.insert_at(tape.left, length(tape.left), value)

    init(new_left, new_right)
  end

  # Gets the content of the tape
  def contents(tape) do
    tape
  end

  # Checks if it's tape end
  def end?(tape) do
    at(tape) == "$"
  end
end
