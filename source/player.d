module player;

import raylib;

struct Player {

    static double tester = 0;

    // Position is the base of the player, centered
    Vector3 position;
    Vector3 inertia;
    // Eyeheight is the Y position of the player + this
    double eyeHeight = 1.5;

    this(Vector3 startPosition) {
        this.position = startPosition;
        this.inertia = Vector3(0,0,0);
    }
}