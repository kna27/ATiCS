public class Transition {
    public enum Direction {
        LEFT, RIGHT;
    }

    private char symbol;
    private char write;
    private Direction direction;
    private State nextState;

    public Transition(char symbol, char write, Direction direction, State nextState) {
        this.symbol = symbol;
        this.write = write;
        this.direction = direction;
        this.nextState = nextState;
    }

    public char getSymbol() {
        return this.symbol;
    }

    public char getWrite() {
        return this.write;
    }

    public Direction getDirection() {
        return this.direction;
    }

    public State getNextState() {
        return this.nextState;
    }
}
