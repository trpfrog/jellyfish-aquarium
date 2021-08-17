Aquarium aquarium = new Aquarium();

void setup() {
    size(800, 450, P3D);
    hint(DISABLE_DEPTH_TEST);
    noStroke();
}

void draw() {
    translate(width / 2, height / 2);
    rotateX(map(mouseY, 0, height, TWO_PI, 0));
    rotateY(map(-mouseX, 0, width, -PI, PI));

    background(255);
    aquarium.draw();
    drawAxis();
}
