defmodule FiniteAutomata do
  def init_automata(transitions, initial_state, accept_states) do
    %{
      transitions: transitions,
      initial_state: initial_state,
      accept_states: accept_states,
      current_state: initial_state
    }
  end

  # Gets a new tape with a given input
  def get_tape(input) do
    left = ["$"]
    right = List.insert_at(input, length(input), "$")
    # Returning created tape
    Tape.init(left, right)
  end

  def get_new_states(automata, tape) do
    current_input = Tape.at(tape)
    # Retuning the new states
    automata.transitions
      # Getting only transitions for the current_state
      |> Map.get(automata.current_state)
      # Fitering transitions that accepts the current_input
      |> Enum.filter(fn {elem, _state} -> elem == current_input end)
      # Getting only state
      |> Enum.map(fn {_elem, state} -> state end)
  end

  def update_automata(automata, new_state) do
    # Setting new state
    automata
      |> Map.put(:current_state, new_state)
  end

  def accept_state?(automata) do
    Enum.member?(automata.accept_states, automata.current_state)
  end

  def run_acceptor(automata, tape) do
    # Checking if is tape end
    if Tape.end?(tape) do
      accept_state?(automata)
    else
      # Getting new states
      new_states = get_new_states(automata, tape)
      # Reconfig tape
      new_tape = Tape.reconfig(tape)
      # For each one of the possible states, we create a new automata and run acceptor
      new_states
        |> Enum.any?(fn new_state ->
          # Updating automata
          new_automata = update_automata(automata, new_state)
          # Calling run_acceptor again with updated data
          run_acceptor(new_automata, new_tape)
        end)
    end
  end
end
