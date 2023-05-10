public class StateMachine {
    public State[] states;
    public State currentState;
    public Tape tape;
    public char[] alphabet;
    public int initialInputSize;

    public StateMachine(State[] states, Tape tape, char[] alphabet) {
        this.states = states;
        this.currentState = states[0];
        this.tape = tape;
        this.alphabet = alphabet;
        this.initialInputSize = tape.getSize();
    }

    public void run() {
        while (!this.currentState.isTerminal()) {
            this.step();
        }
    }

    public void step() {
        char input = this.tape.read();
        Transition transition = this.currentState.getTransition(input);
        this.tape.write(transition.getSymbol());
        if (transition.getDirection() == Transition.Direction.LEFT) {
            this.tape.left();
        } else {
            this.tape.right();
        }
        this.currentState = transition.getNextState();
    }

    public int oneCount() {
        return this.tape.oneCount();
    }

    public float score() {
        return ((float) this.tape.oneCount()) / ((float) this.states.length * (float) this.alphabet.length * (float) this.initialInputSize);
    }
}
