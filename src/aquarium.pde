class Aquarium extends Drawable {

    private int aquariumWidth = 180;
    private int aquariumHeight = 100;
    private int aquariumDepth = 100;
    private int frameThickness = 2;
    protected int waterHeight;
    protected int sandHeight;

    private Food food = new Food();

    ArrayList<AquaticLife> seaObjects = new ArrayList<AquaticLife>();
    Drawable house, car;

    public Aquarium() {
        this(180, 100, 100);
    }

    public Aquarium(int width, int height, int depth) {
        aquariumWidth = width;
        aquariumHeight = height;
        aquariumDepth = depth;
        waterHeight = (int)(aquariumHeight * 0.85);
        sandHeight = (int)(aquariumHeight * 0.1);

        for(int i = 0; i < 150; i++) {
            Seaweed sw = new Seaweed(
                4 + abs(randomGaussian()) * 2, 25 + randomGaussian() * 3, 0.5, 4, 16000
            );
            final int padding = 10;
            sw.setLocation(
                random(-aquariumWidth/2 + padding, aquariumWidth/2 - padding),
                0,
                random(-aquariumDepth/2 + padding, aquariumDepth/2 - padding)
            );
            sw.setColor(color(100, 200 + randomGaussian() * 10, 100, 190));
            sw.setInitalPhase(randomGaussian());
            seaObjects.add(sw);
        }

        house = new House();
        car = new Car();

        color[] jellycolor = {#ffa8ff, #a8ffff, #a8ffa8, #ffffa8};
        for(int i = 0; i < 4; i++) {
            AquaticLife jf = new Jellyfish(jellycolor[i]);
            jf.setLocation(
                aquariumWidth * random(0, 1) - aquariumWidth / 2, 
                waterHeight * random(0, 1), 
                aquariumDepth * random(0, 1) - aquariumDepth / 2
            );
            seaObjects.add(jf);
        }
    }

    @Override
    public void draw() {
        pushStyle();
            hint(ENABLE_DEPTH_TEST);
                drawSand();
                for(AquaticLife life : seaObjects) {
                    pushMatrix();
                        translate(life.getX(), life.getY(), life.getZ());
                        life.draw();
                    popMatrix();
                    if(life instanceof Movable) {
                        ((Movable)life).move(this);
                    }
                }
                food.draw();
                food.move(this);
                drawHouse();
                drawCar();
            hint(DISABLE_DEPTH_TEST);
            fillWithWater();
            hint(ENABLE_DEPTH_TEST);
            drawFrame();
        popStyle();
    }

    private void fillWithWater() {
        pushStyle();
        fill(#7FCCE3, 10);
        pushMatrix();
            translate(0, (waterHeight + sandHeight) / 2, 0);
            box(
                aquariumWidth - frameThickness, 
                waterHeight - sandHeight, 
                aquariumDepth - frameThickness
            );
        popMatrix();
        popStyle();
    }

    private void drawFrame() {
        fill(40);
        pushMatrix();
            translate(0, -frameThickness/2, 0);
            box(
                aquariumWidth + frameThickness, 
                frameThickness, 
                aquariumDepth + frameThickness
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
                box(frameThickness, aquariumHeight, frameThickness);
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
                    aquariumWidth * abs(dz[i]) + frameThickness,
                    frameThickness,
                    aquariumDepth * abs(dx[i]) + frameThickness
                );
                // Draw window
                // translate(0, -aquariumHeight / 2, 0);
                // pushStyle();
                //     fill(#555555, 100);
                //     box(
                //         aquariumWidth * abs(dz[i]),
                //         aquariumHeight - frameThickness,
                //         aquariumDepth * abs(dx[i])
                //     );
                // popStyle();
            popMatrix();
        }
    }

    private void drawHouse() {
        pushMatrix();
            translate(aquariumWidth * 0.25, sandHeight * 0.8, aquariumDepth * 0.2);
            rotateY(1.5 * PI);
            rotateX(-0.1 * PI);
            rotateZ(-0.1 * PI);
            house.draw(10);
        popMatrix();
    }

    private void drawCar() {
        pushMatrix();
            rotateY(PI);
            translate(aquariumWidth * 0.25, sandHeight * 0.8, aquariumDepth * 0.3);
            rotateY(PI);
            rotateX(0.2 * PI);
            rotateZ(0.2 * PI);
            car.draw(10);
        popMatrix();
    }

    private void drawSand() {
        fill(158, 125, 86);
        pushMatrix();
            translate(0, sandHeight / 2, 0);
            box(
                aquariumWidth - frameThickness, 
                sandHeight, 
                aquariumDepth - frameThickness
            );
        popMatrix();
        noFill();
        PVector translateVec = new PVector(
            -(aquariumWidth / 2 - frameThickness / 2), 
            sandHeight + 0.01, 
            -(aquariumDepth / 2 - frameThickness / 2)
        );
        repeatTile(
            translateVec, 
            aquariumWidth - frameThickness,
            aquariumDepth - frameThickness,
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

    public int getFrameThickness() {
        return frameThickness;
    }

    public Food getFood() {
        return food;
    }
}
