import std.stdio;
import std.math;
import std.random;
import fish;
import raylib;

void main() {
	Fish fishy = new Fish();

	fishy.debugger();

	InitWindow(800, 800, "test");

	Random random = Random(100);

	double test = uniform(0.0, 100.0, random);

	writeln("test is: ", test);

	while (!WindowShouldClose()) {
		BeginDrawing();


		ClearBackground(Color(255,255,255,255));

		EndDrawing();
	}
}
