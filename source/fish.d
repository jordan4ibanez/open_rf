module fish;

import std.stdio;
import std.random;
import std.uuid;
import std.math;
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
Vector3 giveRandomRotation(Random random) {
	return Vector3(
		uniform(-50.0, 50.0, random),
		uniform(-180.0, 180.0, random),
		0
	);
}

// Dispatches random values for animation & AI
double giveRandomStateTimer(Random random) {
	return uniform(5.0,20.0, random);
}
double giveRandomMovementTimer(Random random) {
	return uniform(3.0,10.0, random);
	// return uniform(0.5,1.0, random); // Debug
}

struct Fish {
	// This makes the fish unique
	UUID uuid;

	// 3D spacial variables
	Vector3 position;
	Vector3 rotation;
	Vector3 positionGoal;

	// AI variables
	double life = 0;
	double exhaustion = 0;
	double stateTimer = 0;

	// Movement Variables
	double movementTimer = 0;
	double movementSpeed = 0;
	// These will be defined by the fish registration
	double minNormalSpeed = 0;
	double maxNormalSpeed = 0;
	double minSprintSpeed = 0;
	double maxSprintSpeed = 0;
	
	
	FishState state;

	// Animation variables
	Vector3 rotationGoal;

	// Constructor
	this(Vector3 position, double life, double exhaustion, UUID uuid) {

		Random random = Random(unpredictableSeed());

		this.position.x = position.x;
		this.position.y = position.y;
		this.position.z = position.z;

		this.positionGoal.x = position.x;
		this.positionGoal.y = position.y;
		this.positionGoal.z = position.z;

		this.rotation = giveRandomRotation(random);

		// Clone the rotations so the fish do not randomly spin at start
		this.rotationGoal.x = this.rotation.x;
		this.rotationGoal.y = this.rotation.y;
		this.rotationGoal.z = this.rotation.z;

		this.life = life;
		this.exhaustion = exhaustion;
		this.stateTimer = giveRandomStateTimer(random);
		this.movementTimer = giveRandomMovementTimer(random);

		this.state = giveRandomStartState(random);

		this.uuid = uuid;
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
	void onTick(double delta) {

		Random random = Random(unpredictableSeed());
		/*	
		Note: This needs a branch to check if the fish is engaged with the lure or bait
		if it is, it needs to automatically ignore everything and lock into it's current branch
		it also needs to check if the lure or bait is near if even in the water
		*/

		// Tick down the timers
		if (this.stateTimer > 0) {
			this.stateTimer -= delta;
		} else {
			// This resets the movement timer to allow the
			// fish to react in it's new state immediately
			this.movementTimer = 0;
			this.stateTimer = giveRandomStateTimer(random);
			this.state = giveRandomStartState(random);
		}

		if (this.movementTimer > 0) {
			this.movementTimer -= delta;
		}

		// This is debug, if something is going seriously wrong it's probably here
		this.state = FishState.WANDER;
		

		switch (this.state) {
			case FishState.RELAX: {

				// Linear interpolation is slower when relaxed
				this.rotation = Vector3Lerp(
					this.rotation,
					this.rotationGoal,
					0.025
				);

				// Look around randomly
				if (this.movementTimer <= 0) {
					this.rotationGoal = giveRandomRotation(random);
					this.movementTimer = giveRandomMovementTimer(random);
				}

				break;
			}
			case FishState.WANDER: {

				// Linear interpolation is slightly faster when wandering
				this.rotation = Vector3Lerp(
					this.rotation,
					this.rotationGoal,
					0.04
				);

				// Look around randomly
				if (this.movementTimer <= 0) {
					this.rotationGoal = giveRandomRotation(random);
					this.movementTimer = giveRandomMovementTimer(random);
				}

				// writeln("FISH ID: ", this.uuid, " is just wandering around");
				//this.position += Vector3Normalize(this.rotation) * delta * 2.0;


				double speed = 3;
				// Pitch is the X component of the fish's rotation
				this.position.y += sin( DEG2RAD * this.rotation.x ) * delta * speed; // * movement speed


				// Yaw is the Y component of the fish's rotation
				this.position.x += -sin( DEG2RAD * this.rotation.y ) * delta * speed; // * movement speed
				this.position.z +=  cos( DEG2RAD * this.rotation.y ) * delta * speed; // * movement speed
				/*
				Roll is the Z component of the fish's rotation
				Roll will only be utilized for fish tanks with dying/dead fish in production
				The Fish's AI and movement logic will not incorperate the Z component, just documentation
				*/
				/*
				needs to implement COS and ATAN or TAN to convert radians into real direction
				*/

				break;
			}
			case FishState.SPRINT: {
				writeln("FISH ID: ", this.uuid, " HAS SOMEWHERE TO BE!!");
				break;
			}
			default: {
				writeln("Something has gone extremely wrong with fish ID: ", this.uuid);
				writeln("WARNING: FISH ID ", this.uuid, " HAS DEFAULTED IN IT'S FISHSTATE!");
			}
		}
	}


	// This will heavily change in the future
	void debugger() {
		// writeln("FISH ID: ", this.ID, " | I am at X: ", this.position.x, " | Y: ", this.position.y, " | Z: ", this.position.z);
		writeln("FISH ID: ", this.uuid, " IS IN STATE: ", this.state);
	}

	void printPos() {
		writeln(this.position);
	}
}