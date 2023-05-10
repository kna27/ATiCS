public class State {
    private String name;
    private Transition[] transitions;
    private boolean terminal;

    public State(String name, boolean terminal) {
        this.name = name;
        this.transitions = new Transition[0];
        this.terminal = terminal;
    }

    public String getName() {
        return this.name;
    }

    public Transition getTransition(char symbol) {
        for (Transition transition : this.transitions) {
            if (transition.getSymbol() == symbol) {
                return transition;
            }
        }
        throw new IllegalArgumentException();
    }

    public Transition[] getTransitions() {
        return this.transitions;
    }

    public boolean isTerminal() {
        return this.terminal;
    }

    public void addTransition(Transition t) {
        Transition[] newTransitions = new Transition[this.transitions.length + 1];
        for (int i = 0; i < this.transitions.length; i++) {
            newTransitions[i] = this.transitions[i];
        }
        newTransitions[this.transitions.length] = t;
        this.transitions = newTransitions;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
