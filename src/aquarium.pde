class Aquarium extends Drawable {

    private int aquariumWidth = 180;
    private int aquariumHeight = 100;
    private int aquariumDepth = 100;
    private int frameHeight = 4;
    protected int waterHeight;
    protected int sandHeight;

    ArrayList<AquaticLife> seaObjects = new ArrayList<AquaticLife>();

    public Aquarium() {
        this(180, 100, 100);
    }

    public Aquarium(int width, int height, int depth) {
        aquariumWidth = width;
        aquariumHeight = height;
        aquariumDepth = depth;
        waterHeight = (int)(aquariumHeight * 0.8);
        sandHeight = (int)(aquariumHeight * 0.1);

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
        fill(40);
        pushMatrix();
            translate(0, -frameHeight/2, 0);
            box(
                aquariumWidth + frameHeight, 
                frameHeight, 
                aquariumDepth + frameHeight
            );
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
                // Draw window
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

    private void drawSand() {
        fill(#dcd3b2);
        pushMatrix();
            translate(0, sandHeight / 2, 0);
            box(
                aquariumWidth - frameHeight, 
                sandHeight, 
                aquariumDepth - frameHeight
            );
        popMatrix();
        noFill();
        PVector translateVec = new PVector(
            -(aquariumWidth / 2 - frameHeight / 2), 
            sandHeight + 0.01, 
            -(aquariumDepth / 2 - frameHeight / 2)
        );
        repeatTile(
            translateVec, 
            aquariumWidth - frameHeight,
            aquariumDepth - frameHeight,
            SAND_TEXTURE,
            40
        );
    }

    public int getWidth() {
        return aquariumWidth;
    }

    public int getHeight() {
        return aquariumHeight;
    }

    public int getDepth() {
        return aquariumDepth;
    }

    public int getWaterHeight() {
        return waterHeight;
    }

    public int getSandHeight() {
        return sandHeight;
    }

    public boolean addFood(int x, int y, int z) {
        if(this.hasFood()) return false;

        return true;
    }

    public boolean hasFood() {
        return this.getFoodLocation() != null;
    }

    public PVector getFoodLocation() {
        return null;
    }
}
