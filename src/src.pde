Aquarium aquarium = new Aquarium();

void setup() {
    size(800, 450, P3D);
    setupTextures();
    hint(DISABLE_DEPTH_TEST);
    noStroke();
}

void draw() {
    translate(width / 2, height / 2);
    cameraWork.update();

    scale(2);
    lights();
    spotLight(130, 100, 180, 0, 1000, 0, 0, -1, 0, PI, 2);

    translate(0, -70, 0);
    background(#202030);
    drawFloor(100);
    aquarium.draw();
    drawStand(100);
}

void drawStand(int standHeight) {
    pushMatrix();
        translate(0, -standHeight / 2 - aquarium.getFrameThickness(), 0);
        texturedBox(
            aquarium.getWidth() + aquarium.getFrameThickness() + 2,
            standHeight,
            aquarium.getDepth() + aquarium.getFrameThickness() + 2,
            MARBLE_TEXTURE
        );
    popMatrix();
}

void drawFloor(int standHeight) {
    final int floorSize = 10000;
    repeatTile(
        new PVector(-floorSize/2, -standHeight, -floorSize/2),
        floorSize, floorSize,
        FLOOR_TEXTURE, 500
    );
}
