defmodule Tape do
  # Inits a new tape
  def init(left, right) do
    %{ left: left, right: right }
  end

  def at(tape) do
    List.first(tape.right)
  end

  def reconfig(tape) do
    { value, new_right } = List.pop_at(tape.right, 0)
    new_left = List.insert_at(tape.left, length(tape.left), value)

    init(new_left, new_right)
  end

  def contents(tape) do
    tape
  end
end
