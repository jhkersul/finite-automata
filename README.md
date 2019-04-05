# Finite Automata

This is a Finite Automata implementation using as base the article **Teaching Nondeterministic and Universal Automata using Scheme** by Christian Wagenknecht and Daniel P. Friedman.

This automata utilizes a Tape composed by symbols that are read to decide which transition will occur.

Such algorithm was studied on PCS3556 - Computational Logics at Poli-USP.

Developed using Elixir programming language.

## Example of a scenario

You can create Deterministic or Non-Deterministic automata with this program.

For the following transitions table:

| State/Input | A  | B  |
|-------------|----|----|
| Q0          | Q0 | Q1 |
| Q1          | Q2 | Q1 |
| Q2          | Q2 | Q2 |

You can define your transitions using a Map:

```elixir
transitions = %{
  "q0" => [{"a", "q0"}, {"b", "q1"}],
  "q1" => [{"a", "q2"}, {"b", "q1"}],
  "q2" => [{"a", "q2"}, {"b", "q2"}]
}
```

And then, define your automata:

```elixir
initial_state = "q0"
accept_states = ["q2"]
automata = FiniteAutomata.init_automata(transitions, initial_state, accept_states)
```

To check if "ba" is a accepted string for this automata, you have to define a Tape and run the acceptor:

```elixir
tape = FiniteAutomata.get_tape(["b", "a"])
# Will return :true or :false if the tape was accepted
FiniteAutomata.run_acceptor(automata, tape)
```

## Running tests

All tests are available at `test/finite_automata_test.exs` and `test/tape_test.exs`.

```bash
mix test
```
