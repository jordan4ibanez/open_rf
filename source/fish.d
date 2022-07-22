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


struct FishContainer {

	// Basic fields for now
	bool[]    exists;
	Vector3[] position;
	double[]  life;
    
	void newFish(Vector3 position, double standardLife) {

		// Check if there are any free slots
		bool found      = false;
		ulong indexFound = 0;
		ulong currentSize = this.exists.length;

		// Simple fix to avoid crash on unitialized array
		if (currentSize > 0) {
			for (ulong i = 0; i < this.exists.length; i++) {
				if (!this.exists[i]) {
					found      = true;
					indexFound = i;
					break;
				}
			}
		}

		// Overwrite if a free slot is found
		if (found) {
			this.position[indexFound] = position;
			this.life[indexFound]     = standardLife;
			this.exists[indexFound]   = true;
		}
		// Else append to the end of dynamic array
		else {
			this.position ~= position;
			this.life     ~= standardLife;
			this.exists   ~= true;
		}
		
	}

	// Resets the entire ECS to allow further reuse
	void reset() {
		this.exists[] = false;
	}

	// Allows systems to remove fish
	void removeFish(ulong ID) {
		this.exists[ID] = false;
	}

	// Allows systems to get all fish that exist, or nothing
	ulong[] collectIDs() {
		ulong[] idCollection;
		ulong length = this.exists.length;

		// Skip CPU cycles and just return unitialized array
		if (length <= 0) {
			return idCollection;
		}
		
		// Get all fish that exist
		for (ulong i = 0; i < length; i++) {
			if (this.exists[i]) {
				idCollection ~= i;
			}
		}

		return idCollection;
	}

	// Adds life to a fish, this is a placeholder debug
	void addLife(ulong id, double adder) {
		this.life[id] += adder;
	}

	// Simple getters

	// For specific ID
	Vector3 getPos(ulong id) {
		return this.position[id];
	}

	// For the total length in memory synced
	ulong totalLength() {
		return exists.length;
	}

	// For the real length, this probably should be deprecated
	ulong realLength() {
		return this.collectIDs().length;
	}


	// This will heavily change in the future
	void debugger(ulong id) {
		writeln("FISH ID: ", id,
		" | I am at X: ", this.position[id].x,
		" | Y: ", this.position[id].y,
		" | Z: ", this.position[id].z);
	}

	void printPos(ulong id) {
		writeln(this.position[id]);
	}
}