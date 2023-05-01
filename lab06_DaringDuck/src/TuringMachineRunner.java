package lab06_DaringDuck.src;

public class TuringMachineRunner {

    public static void main(String[] args) {
        // Create states
        State stateA = new State("A", new Transition[0], false);
        State stateB = new State("B", new Transition[0], false);
        State stateC = new State("C", new Transition[0], false);
        State haltState = new State("Halt", new Transition[0], true);

        // Create transitions
        Transition a0 = new Transition('0', '1', false, stateB);
        Transition a1 = new Transition('1', '1', true, stateC);
        Transition b0 = new Transition('0', '1', true, stateA);
        Transition b1 = new Transition('1', '1', false, stateB);
        Transition c0 = new Transition('0', '1', true, stateB);
        Transition c1 = new Transition('1', '1', false, haltState);

        // Set transitions for states
        stateA.transitions = new Transition[]{a0, a1};
        stateB.transitions = new Transition[]{b0, b1};
        stateC.transitions = new Transition[]{c0, c1};

        // Set initial tape
        Tape tape = new Tape("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");

        // Assemble machine
        StateMachine machine = new StateMachine(new State[]{stateA, stateB, stateC, haltState}, tape);

        // Run the machine
        machine.run();

        // Output
        System.out.println("Final tape: " + machine.tape.toString());
        System.out.println("Number of 1s: " + machine.tape.oneCount());
    }
}
