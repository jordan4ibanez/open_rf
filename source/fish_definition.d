module fish_definition;

import std.string;
// The structs which contain the data
struct FishDefinition {
    string name;
    double scale;
    double minNormalSpeed;
	double maxNormalSpeed;
	double minSprintSpeed;
	double maxSprintSpeed;

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