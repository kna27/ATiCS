package lab06_DaringDuck.src;

public class Transition {
    private char input;
    private char write;
    private boolean moveLeft;
    private State nextState;

    public Transition(char input, char write, boolean moveLeft, State nextState) {
        this.input = input;
        this.write = write;
        this.moveLeft = moveLeft;
        this.nextState = nextState;
    }

    public char getInput() {
        return this.input;
    }

    public char getWrite() {
        return this.write;
    }

    public boolean getMoveLeft() {
        return this.moveLeft;
    }

    public State getNextState() {
        return this.nextState;
    }
}
