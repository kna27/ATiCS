package lab06_DaringDuck.src;

public class StateMachine {
    public State[] states;
    public State currentState;
    public Tape tape;
    
    public StateMachine(State[] states, Tape tape) {
        this.states = states;
        this.currentState = states[0];
        this.tape = tape;
    }

    public void run() {
        while (!this.currentState.isTerminal()) {
            this.step();
        }
    }

    public void step() {
        char input = this.tape.read();
        Transition[] transitions = this.currentState.getTransitions();
        for (int i = 0; i < transitions.length; i++) {
            if (transitions[i].getInput() == input) {
                this.tape.write(transitions[i].getWrite());
                if (transitions[i].getMoveLeft()) {
                    this.tape.left();
                } else {
                    this.tape.right();
                }
                this.currentState = transitions[i].getNextState();
                break;
            }
        }
    }
}
