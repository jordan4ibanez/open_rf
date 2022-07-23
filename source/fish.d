module fish;

import std.stdio;
import std.random;
import raylib;

// The possible states that a fish can be in
enum FishState {
	// The fish is just chilling, looking around at nothing
	RELAX,
	// The fish is aimlessly wandering around the map
	WANDER,
	// The fish saw something off in the distance and wants to see it immediately
	SPRINT,
	// The fish is looking at the lure/bait
	FOCUS,
	// The fish is looking at the lure/bait and following
	CHASE,
	// The fish decided the lure/bait is tasty, going in for attack
	ATTACK,
	// The fish is fighting the player, exhaustion is rising
	FIGHT,
	// The fish is fighting the player, the fish is exhausted, player has no trouble reeling in
	FIGHT_EXHAUSTED,
	// The fish is thrashing loose, the hook was not set properly
	FIGHT_BREAKING_LOOSE,
	// The fish has gotten off of the lure/bait, it will run away in a random direction
	ESCAPE
}

// The possible fish states that a fish can start in
FishState[3] STARTER_FISH_STATES = [
	FishState.RELAX,
	FishState.WANDER,
	FishState.SPRINT
];

// Quickly dispatches random starter states
FishState giveRandomStartState(Random random) {
	return STARTER_FISH_STATES[uniform(0,3, random)];
}

// Quickly dispatches random starter rotations
Vector3 giveRandomStartRotation(Random random) {
	return Vector3(
		0,
		uniform(-180.0, 180.0, random),
		0
	);
}

ulong ID_DISPATCHER = 0;

struct Fish {

	ulong ID;
	Vector3 position;
	Vector3 rotation;
	double life = 0;
	double exhaustion = 0;
	FishState state;

	this(Vector3 position, double life, double exhaustion, Random random) {

		this.position.x = position.x;
		this.position.y = position.y;
		this.position.z = position.z;
		this.rotation = giveRandomStartRotation(random);
		this.life = life;
		this.exhaustion = exhaustion;

		this.state = giveRandomStartState(random);

		// I'm sure that this will never overflow with ulong but this is probably a bad idea
		this.ID = ID_DISPATCHER;
		ID_DISPATCHER++;
	}
    
	// Adds life to a fish, this is a placeholder debug
	void addLife(double adder) {
		this.life += adder;
	}

	// Simple getters
	Vector3 getPosition() {
		return this.position;
	}
	Vector3 getRotation() {
		return this.rotation;
	}


	// The fish's AI, what it thinks each tick
	void onTick(double delta, Random random) {
		
	}


	// This will heavily change in the future
	void debugger() {
		// writeln("FISH ID: ", this.ID, " | I am at X: ", this.position.x, " | Y: ", this.position.y, " | Z: ", this.position.z);
		writeln("FISH ID: ", this.ID, " IS IN STATE: ", this.state);
	}

	void printPos() {
		writeln(this.position);
	}
}