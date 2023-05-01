package lab06_DaringDuck.src;

public class State {
    private String name;
    Transition[] transitions;
    private boolean terminal;

    public State(String name, Transition[] transitions, boolean terminal) {
        this.name = name;
        this.transitions = transitions;
        this.terminal = terminal;
    }

    public String getName() {
        return this.name;
    }

    public Transition[] getTransitions() {
        return this.transitions;
    }

    public boolean isTerminal() {
        return this.terminal;
    }
}
