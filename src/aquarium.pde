class Aquarium implements Drawable {

    public static final int AQUARIUM_WIDTH = 180;
    public static final int AQUARIUM_HEIGHT = 100;
    public static final int AQUARIUM_DEPTH = 100;
    public static final int FRAME_WEIGHT = 4;

    @Override
    public void draw() {
        pushStyle();
            drawFrame();
        popStyle();
    }

    private void drawFrame() {
        fill(#000000);
        pushMatrix();
            translate(0, -AQUARIUM_HEIGHT / 2, 0);
            box(AQUARIUM_WIDTH + FRAME_WEIGHT, 10, AQUARIUM_DEPTH + FRAME_WEIGHT);
        popMatrix();
        int[] dx = {1, 1, -1, -1};
        int[] dz = {1, -1, -1, 1};
        for (int i = 0; i < 4; i++) {
            pushMatrix();
                translate(dx[i] * AQUARIUM_WIDTH / 2, 0, dz[i] * AQUARIUM_DEPTH / 2);
                box(FRAME_WEIGHT, AQUARIUM_HEIGHT, FRAME_WEIGHT);
            popMatrix();
        }
        dx = new int[] {1, -1, 0, 0};
        dz = new int[] {0, 0, 1, -1};
        for (int i = 0; i < 4; i++) {
            pushMatrix();
                translate(
                    dx[i] * AQUARIUM_WIDTH / 2,
                    AQUARIUM_HEIGHT / 2,
                    dz[i] * AQUARIUM_DEPTH / 2
                );
                box(
                    AQUARIUM_WIDTH * abs(dz[i]) + FRAME_WEIGHT,
                    FRAME_WEIGHT,
                    AQUARIUM_DEPTH * abs(dx[i]) + FRAME_WEIGHT
                );
                // translate(0, -AQUARIUM_HEIGHT / 2, 0);
                // pushStyle();
                //     fill(#555555, 100);
                //     box(
                //         AQUARIUM_WIDTH * abs(dz[i]),
                //         AQUARIUM_HEIGHT - FRAME_WEIGHT,
                //         AQUARIUM_DEPTH * abs(dx[i])
                //     );
                // popStyle();
            popMatrix();
        }
    }
}