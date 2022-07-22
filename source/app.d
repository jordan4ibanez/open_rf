import std.stdio;
import fish;
import raylib;

void main() {
	Fish fishy = new Fish();

	fishy.debugger();

	destroy(fishy);

	InitWindow(800, 800, "test");
}
