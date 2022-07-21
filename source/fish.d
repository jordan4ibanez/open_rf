module fish;

import std.stdio;

class Fish {
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