class Aquarium extends Drawable {

    private int aquariumWidth = 180;
    private int aquariumHeight = 100;
    private int aquariumDepth = 100;
    private int frameHeight = 4;
    protected int waterHeight = (int)(aquariumHeight * 0.8);

    ArrayList<AquaticLife> seaObjects = new ArrayList<AquaticLife>();

    public Aquarium() {
        this(180, 100, 100);
    }

    public Aquarium(int width, int height, int depth) {
        aquariumWidth = width;
        aquariumHeight = height;
        aquariumDepth = depth;
        waterHeight = (int)(aquariumHeight * 0.8);

        Seaweed sw = new Seaweed();
        sw.setLocation(0, 0, 0);
        seaObjects.add(sw);
    }

    @Override
    public void draw() {
        pushStyle();
            drawFrame();
            fillWithWater();
            for(AquaticLife life : seaObjects) {
                pushMatrix();
                    translate(life.getX(), life.getY(), life.getZ());
                    life.draw(3);
                popMatrix();
            }
        popStyle();
    }

    private void fillWithWater() {
        fill(#7FCCE3, 100);
        pushMatrix();
            translate(0, waterHeight / 2, 0);
            box(
                aquariumWidth - frameHeight, 
                waterHeight - frameHeight, 
                aquariumDepth - frameHeight
            );
        popMatrix();
    }

    private void drawFrame() {
        fill(#000000);
        pushMatrix();
            translate(0, 0, 0);
            box(aquariumWidth + frameHeight, 10, aquariumDepth + frameHeight);
        popMatrix();
        int[] dx = {1, 1, -1, -1};
        int[] dz = {1, -1, -1, 1};
        for (int i = 0; i < 4; i++) {
            pushMatrix();
                translate(
                    dx[i] * aquariumWidth / 2, 
                    aquariumHeight / 2, 
                    dz[i] * aquariumDepth / 2
                );
                box(frameHeight, aquariumHeight, frameHeight);
            popMatrix();
        }
        dx = new int[] {1, -1, 0, 0};
        dz = new int[] {0, 0, 1, -1};
        for (int i = 0; i < 4; i++) {
            pushMatrix();
                translate(
                    dx[i] * aquariumWidth / 2,
                    aquariumHeight,
                    dz[i] * aquariumDepth / 2
                );
                box(
                    aquariumWidth * abs(dz[i]) + frameHeight,
                    frameHeight,
                    aquariumDepth * abs(dx[i]) + frameHeight
                );
                // translate(0, -aquariumHeight / 2, 0);
                // pushStyle();
                //     fill(#555555, 100);
                //     box(
                //         aquariumWidth * abs(dz[i]),
                //         aquariumHeight - frameHeight,
                //         aquariumDepth * abs(dx[i])
                //     );
                // popStyle();
            popMatrix();
        }
    }
}
