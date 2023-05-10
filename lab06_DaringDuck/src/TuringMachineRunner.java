public class TuringMachineRunner {

  public static final boolean debug = false;

  public static void main(String[] args) {
    State A = new State("a", false);
    State B = new State("b", false);
    State C = new State("c", false);
    State D = new State("d", false);
    State E = new State("e", false);
    State H = new State("h", true);

    A.addTransition(new Transition('0', '1', Transition.Direction.RIGHT, B));
    A.addTransition(new Transition('1', '0', Transition.Direction.LEFT, D));
    B.addTransition(new Transition('0', '1', Transition.Direction.LEFT, C));
    B.addTransition(new Transition('1', '1', Transition.Direction.RIGHT, D));
    C.addTransition(new Transition('0', '1', Transition.Direction.LEFT, A));
    C.addTransition(new Transition('1', '1', Transition.Direction.LEFT, C));
    D.addTransition(new Transition('0', '1', Transition.Direction.RIGHT, H));
    D.addTransition(new Transition('1', '1', Transition.Direction.RIGHT, E));
    E.addTransition(new Transition('0', '1', Transition.Direction.RIGHT, A));
    E.addTransition(new Transition('1', '0', Transition.Direction.RIGHT, B));

    State[] states = { A, B, C, D, E, H };
    char[] alphabet = { '0', '1', ' ' };
    Tape tape = new Tape("0");

    StateMachine machine = new StateMachine(states, tape, alphabet);
    machine.run();
    System.out.println("Total Steps: " + machine.totalSteps);
    System.out.println("One Count: " + machine.oneCount());
    System.out.println("Score: " + machine.score());
  }
}
