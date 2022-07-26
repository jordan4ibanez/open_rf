module player;

import raylib;

struct Player {

    Vector3 position;
    Vector3 inertia;

    this(Vector3 startPosition) {
        this.position.x = startPosition.x;
        this.position.y = startPosition.y;
        this.position.z = startPosition.z;

        this.inertia = Vector3(0,0,0);
    }
}