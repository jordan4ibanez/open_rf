module player;

import std.stdio;
import raylib;

struct Player {

    // Position is the base of the player, centered
    Vector3 position;
    Vector3 inertia;
    // Eyeheight is the Y position of the player + this
    double eyeHeight = 1.5;

    this(Vector3 startPosition) {
        this.position = startPosition;
        this.inertia = Vector3(0,0,0);
    }

    Vector3 getPos() {
        return this.position;
    }

    Vector3 getCameraPos() {
        return Vector3(
            this.position.x,
            this.position.y + this.eyeHeight,
            this.position.z
        );
    }

    void onTick(double delta, Camera camera) {
        

        if (IsKeyDown(KeyboardKey.KEY_W)) {

            // Camera's target becomes more skewed the further from 0,0,0 it is
            // This corrects it, allowing direct calculations with it
            Vector2 direction = Vector2Normalize(
                Vector2(
                    camera.target.x - camera.position.x,
                    camera.target.z - camera.position.z
                )
            );

            // This will intake inertia soon enough
            double speed = 2;

            this.position.x += direction.x * delta * speed;
            this.position.z += direction.y * delta * speed;
        }
    }
}