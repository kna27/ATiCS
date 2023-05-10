public class TuringMachineRunner {

  public static void main(String[] args) {
    State startState = new State("start", new Transition[0], false);
    State endState = new State("end", new Transition[0], true);
    Transition startToEndTransition = new Transition('1', Transition.Direction.RIGHT, endState);
    startState.addTransition(startToEndTransition);
    State[] states = { startState, endState };
    char[] alphabet = { '0', '1', ' '};
    Tape tape = new Tape("1");
    StateMachine machine = new StateMachine(states, tape, alphabet);
    System.out.println("running machine");
    machine.run();
    System.out.println("One Count: " + machine.oneCount());
    System.out.println("Score: " + machine.score());
  }
}
