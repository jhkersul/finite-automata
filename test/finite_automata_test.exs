defmodule FiniteAutomataTest do
  use ExUnit.Case
  doctest FiniteAutomata

  test "should create a automata" do
    transitions = %{ "q0" => [{"a", "q0"}, {"b", "q1"}] }
    accept_states = ["q1"]
    initial_state = "q0"
    assert FiniteAutomata.init_automata(transitions, initial_state, accept_states) ==
      %{
        transitions: transitions,
        initial_state: initial_state,
        accept_states: accept_states,
        current_state: initial_state
      }
  end

  test "should add the tape to automata with input" do
    assert FiniteAutomata.get_tape(["h", "e"]) ==
      %{ left: ["$"], right: ["h", "e", "$"] }
  end

  test "should apply transitions to automata" do
    transitions = %{ "q0" => [{"a", "q0"}, {"b", "q1"}] }
    initial_state = "q0"
    accept_states = ["q1"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["b"])

    assert FiniteAutomata.get_new_states(automata, tape) ==
      ["q1"]
  end

  test "should apply transitions with a invalid state" do
    transitions = %{ "q0" => [{"a", "q0"}, {"b", "q1"}] }
    initial_state = "q0"
    accept_states = ["q1"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["c"])

    assert FiniteAutomata.get_new_states(automata, tape) == []
  end

  test "update automata" do
    transitions = %{ "q0" => [{"a", "q0"}, {"b", "q1"}] }
    initial_state = "q0"
    accept_states = ["q1"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    new_state = "q1"

    assert FiniteAutomata.update_automata(automata, new_state).current_state == "q1"
  end

  test "should validate accept state" do
    transitions = %{ "q0" => [{"a", "q0"}, {"b", "q1"}] }
    initial_state = "q1"
    accept_states = ["q1"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)

    assert FiniteAutomata.accept_state?(automata) == :true
  end

  test "should run acceptor valid input" do
    transitions = %{
      "q0" => [{"a", "q0"}, {"b", "q1"}],
      "q1" => [{"a", "q2"}, {"b", "q1"}],
      "q2" => [{"a", "q2"}, {"b", "q2"}]
    }
    initial_state = "q0"
    accept_states = ["q2"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["b", "a"])

    assert FiniteAutomata.run_acceptor(automata, tape) == :true
  end

  test "should run acceptor invalid input" do
    transitions = %{
      "q0" => [{"a", "q0"}, {"b", "q1"}],
      "q1" => [{"a", "q2"}, {"b", "q1"}],
      "q2" => [{"a", "q2"}, {"b", "q2"}]
    }
    initial_state = "q0"
    accept_states = ["q2"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["a", "b"])

    assert FiniteAutomata.run_acceptor(automata, tape) == :false
  end

  test "should run acceptor valid input non-deterministic" do
    transitions = %{
      "q0" => [{"a", "q0"}, {"a", "q1"}, {"b", "q1"}],
      "q1" => [{"a", "q2"}, {"b", "q0"}],
      "q2" => [{"a", "q2"}, {"b", "q2"}]
    }
    initial_state = "q0"
    accept_states = ["q2"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["a", "a"])

    assert FiniteAutomata.run_acceptor(automata, tape) == :true
  end

  test "should run acceptor invalid input non-deterministic" do
    transitions = %{
      "q0" => [{"a", "q0"}, {"a", "q1"}, {"b", "q1"}],
      "q1" => [{"a", "q2"}, {"b", "q0"}],
      "q2" => [{"a", "q2"}, {"b", "q2"}]
    }
    initial_state = "q0"
    accept_states = ["q2"]
    automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
    tape = FiniteAutomata.get_tape(["a", "b", "b"])

    assert FiniteAutomata.run_acceptor(automata, tape) == :false
  end
end
