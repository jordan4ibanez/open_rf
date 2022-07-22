module fish;

import std.stdio;
import raylib;

// The possible states that a fish can be in
enum FishStates {
	RELAX,
	WANDER,
	FOCUS,
	CHASE,
	ATTACK,
	FIGHT,
	FIGHT_EXHAUSTED,
	FIGHT_BREAKING_LOOSE,
	ESCAPE
}

ulong ID_DISPATCHER = 0;

struct FishContainer {

	ulong ID;
	Vector3 position;
	double life = 0;
	double exhaustion = 0;

	this(Vector3 position, double life, double exhaustion) {
		this.position.x = position.x;
		this.position.y = position.y;
		this.position.z = position.z;
		this.life = life;
		this.exhaustion = exhaustion;
		this.ID = ID_DISPATCHER;

		ID_DISPATCHER++;
	}
    
	// Adds life to a fish, this is a placeholder debug
	void addLife(ulong id, double adder) {
		this.life += adder;
	}

	// Simple getters

	// For specific ID
	Vector3 getPos(ulong id) {
		return this.position;
	}


	// This will heavily change in the future
	void debugger() {
		writeln("FISH ID: ", this.ID,
		" | I am at X: ", this.position.x,
		" | Y: ", this.position.y,
		" | Z: ", this.position.z);
	}

	void printPos() {
		writeln(this.position);
	}
}