package lab06_DaringDuck.src;

public class Tape {
    private char[] tape;
    private int head;
    private int size;

    public Tape(String input) {
        this.tape = input.toCharArray();
        this.head = 0;
        this.size = input.length();
    }

    public void left() {
        if (this.head == 0) {
            this.resize();
        }
        this.head--;
    }

    public void right() {
        if (this.head == this.size - 1) {
            this.resize();
        }
        this.head++;
    }

    public char read() {
        return this.tape[this.head];
    }

    public void write(char c) {
        this.tape[this.head] = c;
    }

    public void resize() {
        char[] newTape = new char[this.size * 2];
        for (int i = 0; i < this.size; i++) {
            newTape[i] = this.tape[i];
        }
        this.tape = newTape;
        this.size = this.size * 2;
    }

    public String toString() {
        String output = "";
        for (int i = 0; i < this.size; i++) {
            output += this.tape[i];
        }
        return output;
    }

    public int oneCount() {
        int count = 0;
        for (int i = 0; i < this.size; i++) {
            if (this.tape[i] == '1') {
                count++;
            }
        }
        return count;
    }
    
}
