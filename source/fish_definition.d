module fish_definition;

import std.string;
import raylib;

// The structs which contain the data
struct FishDefinition {
    // General settings
    string name;
    double scale; // This needs a min/max along with weight
    double minNormalSpeed;
	double maxNormalSpeed;
	double minSprintSpeed;
	double maxSprintSpeed;

    // Mesh settings
    Mesh mesh; // This will automatically attach the texture
    
    // Constructor
    this(
        string name,
        double scale,
        double minNormalSpeed,
        double maxNormalSpeed,
        double minSprintSpeed,
        double maxSprintSpeed) {

        this.name = name;
        this.scale = scale;
        this.minNormalSpeed = minNormalSpeed;
        this.maxNormalSpeed = maxNormalSpeed;
        this.minSprintSpeed = minSprintSpeed;
        this.maxSprintSpeed = maxSprintSpeed;
    }
}

// The struct which holds the definition structs
struct FishDefinitionContainer {
    
    FishDefinition[string] data;

    void registerFish(FishDefinition newDefinition) {
        this.data[newDefinition.name] = newDefinition;
    }

    FishDefinition getFish(string name) {
        return data[name];
    }
}