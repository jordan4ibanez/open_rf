import std.stdio;
import fish;
import raylib;

void main() {
	Fish fishy = new Fish();

	fishy.debugger();

	InitWindow(800, 800, "test");
}
