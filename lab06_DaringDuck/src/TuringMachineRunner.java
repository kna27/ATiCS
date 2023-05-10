public class TuringMachineRunner {

  public static void main(String[] args) {
    State startState = new State("start", new Transition[0], false);
    State endState = new State("end", new Transition[0], true);
    Transition startToEndTransition = new Transition('1', Transition.Direction.RIGHT, endState);
    startState.addTransition(startToEndTransition);
    State[] states = { startState, endState };
    Tape tape = new Tape("1");
    StateMachine machine = new StateMachine(states, tape);
    System.out.println("running machine");
    System.out.println(machine.states[0].getTransitions()[0].getSymbol());
    machine.run();
    System.out.println(machine.oneCount());
  }
}
