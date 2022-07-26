module player;

import raylib;

struct Player {

    // Position is the base of the player, centered
    Vector3 position;
    Vector3 inertia;
    double eyeHeight = 1.5;

    this(Vector3 startPosition) {
        this.position.x = startPosition.x;
        this.position.y = startPosition.y;
        this.position.z = startPosition.z;

        this.inertia = Vector3(0,0,0);
    }
}