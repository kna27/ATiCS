public class Transition {
    public enum Direction {
        LEFT, RIGHT;
    }

    private char symbol;
    private Direction direction;
    private State nextState;

    public Transition(char symbol, Direction direction, State nextState) {
        this.symbol = symbol;
        this.direction = direction;
        this.nextState = nextState;
    }

    public char getSymbol() {
        return this.symbol;
    }

    public Direction getDirection() {
        return this.direction;
    }

    public State getNextState() {
        return this.nextState;
    }
}
