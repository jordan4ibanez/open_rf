module fish_definition;

import std.stdio;
import std.string;
import raylib;

// The structs which contain the data
struct FishDefinition {
    // General settings
    string name;
    double minScale;
    double maxScale;
    double minNormalSpeed;
	double maxNormalSpeed;
	double minSprintSpeed;
	double maxSprintSpeed;

    // Model settings
    Model model;
	Texture texture;
    
    // Constructor
    this(
        string name,
        string modelLocation,
        string modelTextureLocation,
        double minScale,
        double maxScale,
        double minNormalSpeed,
        double maxNormalSpeed,
        double minSprintSpeed,
        double maxSprintSpeed) {
        // Arguments end here

        this.name = name;

        this.model = LoadModel(modelLocation.dup.ptr);
        this.texture = LoadTexture(modelTextureLocation.dup.ptr);
        this.model.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = this.texture;

        this.minScale = minScale;
        this.maxScale = maxScale;
        this.minNormalSpeed = minNormalSpeed;
        this.maxNormalSpeed = maxNormalSpeed;
        this.minSprintSpeed = minSprintSpeed;
        this.maxSprintSpeed = maxSprintSpeed;
    }

    Model getModel() {
        return this.model;
    }
}

// The struct which holds the definition structs
struct FishDefinitionContainer {
    
    FishDefinition[string] data;

    void registerFish(FishDefinition newDefinition) {
        writeln("THE NEW DEFINITION: ", newDefinition.name);
        this.data[newDefinition.name] = newDefinition;
    }

    FishDefinition getFish(string name) {
        return this.data[name];
    }
}