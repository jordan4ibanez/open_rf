import std.stdio;
import std.math;
import std.random;
import std.string;
import raylib;
import fish;


const string gameVersion = "0.0.0";
const byte numberOfFish = 10;

void main() {

	// A fish tank to hold the fish
	Fish[] fishTank = new Fish[numberOfFish];

	Random random = Random(unpredictableSeed());

	// Lets add some fish in there
	for (byte i = 0; i < numberOfFish; i++) {
		fishTank[i] = Fish(
			Vector3(
				uniform(-20.0, 20.0, random),
				0.0,
				uniform(-20.0, 20.0, random)
			),
			uniform(0.0, 100.0, random),
			uniform(0.0, 100.0, random),
		);
	}


	// Now let's see where those fish are located in memory
	writeln("--------------------");
	writeln("Here are those fish:");
	writeln("--------------------");
	for (byte i = 0; i < numberOfFish; i++) {
		fishTank[i].debugger();
	}
	writeln("--------------------");


	// Now, let's REALLY see where those fish are

	InitWindow(800, 800,("OpenRF " ~ gameVersion).ptr);

	SetTargetFPS(60);

	SetWindowState(ConfigFlags.FLAG_WINDOW_RESIZABLE);

	InitAudioDevice();

	Model fish = LoadModel("models/rainbowtrout.obj");
	Texture fishTexture = LoadTexture("models/rainbowtrout.png");
	fish.materials[0].maps[MATERIAL_MAP_DIFFUSE].texture = fishTexture;
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


	Vector3 cameraTarget = fishTank[0].getPos();

	// Music things
	Music music = LoadMusicStream("music/calmant.ogg");
	SetMusicVolume(music, 0.6);
	PlayMusicStream(music);

	while (!WindowShouldClose()) {


		UpdateMusicStream(music);

		BeginDrawing();

		timer++;

		// Fancy linear interpolation, probably makes a lot of objects in the heap
		camera.target = Vector3Lerp(camera.target, cameraTarget, 0.1);

		if (timer >= 120) {
			selection++;
			if (selection >= numberOfFish){
				selection = 0;
			}

			cameraTarget = fishTank[selection].getPos();

			timer = 0;
		}


		UpdateCamera(&camera);

		ClearBackground(Color(0,105,148,255));

		BeginMode3D(camera);



		for (byte i = 0; i < numberOfFish; i++) {

			/*
			switch (thisFish.species) {
				case FishSpecies.TROUT: {
					writeln("dis a trout");
					break;
				}
				default: {
					writeln("o no dis no fish");
				}
			}
			*/

			
			DrawModel(fish, fishTank[i].getPos(),1,Colors.RAYWHITE);
		}

		EndMode3D();

		EndDrawing();
	}
}
