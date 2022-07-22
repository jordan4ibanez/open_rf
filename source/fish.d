module fish;

import std.stdio;
import raylib;


class Fish {
	Vector3 position = Vector3(0,0,0);
	double life = 5;
    
	this(double standardLife, Vector3 position) {
		this.life = standardLife;
		this.position.x = position.x;
		this.position.y = position.y;
		this.position.z = position.z;
	}

	void addLife(double adder) {
		this.life += adder;
	}
	void debugger() {
		writeln("I am at ", this.life, " health points!");
	}

	void printPos() {
		writeln(this.position);
	}
}