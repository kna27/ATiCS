public class TuringMachineRunner {

  public static final boolean debug = false;

  public static void main(String[] args) {
    State s0 = new State("s0", false);
    State s1 = new State("s1", false);
    State s2 = new State("s2", false);
    State s3 = new State("s3", false);
    State s4 = new State("s4", false);
    State HALT = new State("halt", true);

    s0.addTransition(new Transition('0', '0', Transition.Direction.RIGHT, s3));
    s0.addTransition(new Transition('1', '0', Transition.Direction.LEFT, s2));
    s1.addTransition(new Transition('0', '1', Transition.Direction.RIGHT, s4));
    s1.addTransition(new Transition('1', '0', Transition.Direction.LEFT, HALT));
    s2.addTransition(new Transition('0', '1', Transition.Direction.LEFT, s0));
    s2.addTransition(new Transition('1', '0', Transition.Direction.LEFT, s4));
    s3.addTransition(new Transition('0', '1', Transition.Direction.RIGHT, s2));
    s3.addTransition(new Transition('1', '1', Transition.Direction.RIGHT, s1));
    s4.addTransition(new Transition('0', '1', Transition.Direction.LEFT, s0));
    s4.addTransition(new Transition('1', '1', Transition.Direction.RIGHT, s0));

    State[] states = { s0, s1, s2, s3, s4, HALT };
    char[] alphabet = { '0', '1', ' ' };
    Tape tape = new Tape("0");

    StateMachine machine = new StateMachine(states, tape, alphabet);
    machine.run();
    System.out.println("One Count: " + machine.oneCount());
    System.out.println("Score: " + machine.score());
  }
}
