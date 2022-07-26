import std.stdio;
import std.math;
import std.random;
import std.string;
import std.uuid;
import raylib;
import fish;
import fish_definition;


const string gameVersion = "0.0.0";
const byte numberOfFish = 100;

void main() {

	
	InitWindow(800, 800,("OpenRF " ~ gameVersion).ptr);

	SetTargetFPS(60);

	SetWindowState(ConfigFlags.FLAG_WINDOW_RESIZABLE);

	InitAudioDevice();

	// A fish tank to hold the fish
	Fish[UUID] fishTank;

	// An array to hold the fish UUID in order
	UUID[] fishUUIDs = new UUID[numberOfFish];

	// A fish tank for the fish definitions
	FishDefinitionContainer fishDefinitions = FishDefinitionContainer();

	// A debug test fish definition, specifically trout
	fishDefinitions.registerFish(FishDefinition(
		"trout",
		"models/rainbowtrout.obj",
		"models/rainbowtrout.png",
		0.5,
		2.0,
		0.5,
		1.3,
		2.0,
		4.0
	));

	fishDefinitions.registerFish(FishDefinition(
		"perch",
		"models/perch.obj",
		"models/perch.png",
		0.5,
		1.3,
		0.5,
		1.3,
		2.0,
		4.0
	));

	Random random = Random(unpredictableSeed());

	// Lets add some fish in there
	for (byte i = 0; i < numberOfFish; i++) {
		UUID uuid = randomUUID();

		FishDefinition thisDefinition = fishDefinitions.giveRandomfishDefinition();

		fishTank[uuid] = Fish(
			thisDefinition,
			Vector3(
				uniform(-40.0, 40.0, random),
				0.0,
				uniform(-40.0, 40.0, random)
			),
			uniform(0.0, 100.0, random),
			uniform(0.0, 100.0, random),
			uuid
		);

		fishUUIDs[i] = uuid;
	}


	// Now let's see where those fish are located in memory
	bool prototype = false;
	if (prototype) {
		writeln("--------------------");
		writeln("Here are those fish:");
		writeln("--------------------");

		foreach (Fish fish; fishTank) {
			fish.debugger();
		}
		writeln("--------------------");
	}


	// Now, let's REALLY see where those fish are

	// Material fishMaterial = LoadMaterialDefault();
	// SetMaterialTexture(&fishMaterial,0, fishTexture);
	// SetModelMeshMaterial(&fish,0, 0);


	Camera camera = Camera(
		Vector3(0,10,10),
		Vector3(0,0,0),
		Vector3(0,1,0),
		55,
		CameraProjection.CAMERA_PERSPECTIVE
	);

	int timer = 0;
	byte selection = 0;


	Vector3 cameraTarget = fishTank[fishUUIDs[0]].getPosition();

	// Music things
	Music music = LoadMusicStream("music/calmant.ogg");
	SetMusicVolume(music, 0.6);
	PlayMusicStream(music);

	while (!WindowShouldClose()) {

		// General logic begins here

		double delta = GetFrameTime();

		UpdateMusicStream(music);

		timer++;

		// Perform fish's logic tick
		foreach (ref Fish fish; fishTank) {
			fish.onTick(delta);
		}

		// This sets the camera to focus on the next fish
		cameraTarget = fishTank[fishUUIDs[selection]].getPosition();

		if ( timer >= 120 ) {
			selection++;
			if (selection >= numberOfFish){
				selection = 0;
			}

			timer = 0;
		}


		// Fancy linear interpolation
		camera.target = Vector3Lerp(camera.target, cameraTarget, 0.1);

		// General logic ends here


		// Drawing logic begins here


		BeginDrawing();

		UpdateCamera(&camera);

		ClearBackground(Color(0,105,148,255));

		BeginMode3D(camera);

		// Reference cubes
		DrawCube(Vector3(0,-10,0),2,2,2,Colors.BLACK);
		DrawCube(Vector3(10,0,0),2,2,2,Colors.BLACK);
		DrawCube(Vector3(-10,0,0),2,2,2,Colors.BLACK);
		DrawCube(Vector3(0,0,10),2,2,2,Colors.BLACK);
		DrawCube(Vector3(0,0,-10),2,2,2,Colors.BLACK);


		// Draw each fish
		foreach (Fish fish; fishTank) {
			Model model = fishDefinitions.getFish(fish.getSpecies()).getModel();
			model.transform = MatrixRotateXYZ(fish.getRotation() * DEG2RAD);
			DrawModel(model, fish.getPosition(),fish.getSize(),Colors.WHITE);
		}

		EndMode3D();

		EndDrawing();
	}
}
