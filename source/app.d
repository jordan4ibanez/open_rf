import std.stdio;
import std.math;
import std.random;
import fish;
import raylib;

void main() {

	Random random = Random(100);

	// A fish tank to hold the fish
	Fish[3] fishTank;

	// Lets add some fish in there
	for (byte i = 0; i < 3; i++) {
		fishTank[i] = new Fish(
			uniform(0.0, 100.0, random),
			Vector3(
				uniform(-20.0, 20.0, random),
				0.0,
				uniform(-20.0, 20.0, random)
			)
		);
	}


	// Now let's see where those fish are located
	writeln("--------------------");
	writeln("Here are those fish:");
	writeln("--------------------");
	for (byte i = 0; i < 3; i++) {
		fishTank[i].printPos();
	}
	writeln("--------------------");


	InitWindow(800, 800, "test");

	while (!WindowShouldClose()) {
		BeginDrawing();


		ClearBackground(Color(255,255,255,255));

		EndDrawing();
	}
}
