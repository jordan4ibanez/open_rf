import std.stdio;

class Test {
	double life = 5;
	this(double standardLife) {
		this.life = standardLife;
	}
	this() {}
	void addLife(double adder) {
		this.life += adder;
	}
	void debugger() {
		writeln("I am at ", this.life, " health points!");
	}
}

void main() {
	Test person = new Test();
	person.addLife(55);
	person.debugger();
}
