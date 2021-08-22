class Car extends Drawable {
    int[] wheelX = {-1, 1, -1, 1};
    int[] wheelZ = {-1, -1, 1, 1};

    protected color shaftColor = color(111);
    protected color wheelColor = color(0);
    
    final float WHEEL_RADIUS = 0.5;

    private void shafts() {
        fill(shaftColor);
        for(int i = 0; i < 2; i++) {
            pushMatrix();
            translate((wheelX[i] + wheelX[i + 2]) / 2, 0, 0);
            rotateX(HALF_PI);
            cylinder(2, 3.0 / 20, 10);
            popMatrix();
        }
    }

    private void wheels() {
        fill(wheelColor);
        int resolution = 50;
        for (int i = 0; i < 4; i++) {
            pushMatrix();
            translate(wheelX[i], 0, wheelZ[i]);
            rotateX(HALF_PI);
            rotateY(PI / 8);
            cylinder(0.4, WHEEL_RADIUS, resolution);
            popMatrix();
        }
    }

    protected void body() {
        fill(#90e200);
        ArrayList<PVector> polys = new ArrayList<PVector>();
        polys.add(new PVector(-2, 0, 0));
        polys.add(new PVector(-1.6, 0, 2));
        polys.add(new PVector(0.5, 0, 2));
        polys.add(new PVector(1, 0, 1));
        polys.add(new PVector(2, 0, 0.75));
        polys.add(new PVector(2, 0, 0));

        final int resolution = 10;
        final float margin = 0.08;
        for(int i = 0; i <= resolution; i++) {
            float x = 1 + (WHEEL_RADIUS + margin) * cos(PI / resolution * i);
            float z = (WHEEL_RADIUS + margin) * sin(PI / resolution * i);
            polys.add(new PVector(x, 0, z));
        }
        for(int i = 0; i <= resolution; i++) {
            float x = -1 + (WHEEL_RADIUS + margin) * cos(PI / resolution * i);
            float z = (WHEEL_RADIUS + margin) * sin(PI / resolution * i);
            polys.add(new PVector(x, 0, z));
        }

        pushMatrix();
            rotateX(-HALF_PI);
            pillar(2.5, polys);
        popMatrix();

        fill(#ffff00);
        pushMatrix();
            translate(1.8, 0.375, -0.75);
            sphere(0.3);
        popMatrix();
        pushMatrix();
            translate(1.8, 0.375, 0.75);
            sphere(0.3);
        popMatrix();
    }

    protected void window() {
        pushMatrix();
            translate(1, 1, 0);
            rotateZ(atan2(0.5, 1));
            translate(0, 0.5, 0);
            fill(#00bfff);
            box(0.05, 0.9, 2.1);
        popMatrix();

        ArrayList<PVector> polys = new ArrayList<PVector>();
        polys.add(new PVector(-1.8, 0, 1));
        polys.add(new PVector(-1.6, 0, 2));
        polys.add(new PVector(0.5, 0, 2));
        polys.add(new PVector(1, 0, 1));
        pushMatrix();
            translate(-0.1, 0.2, 0);
            scale(.8, .8, .8);
            rotateX(-HALF_PI);
            pillar(3.2, polys);
        popMatrix();

        pushMatrix();
            translate(-1.6, 2, 0);
            rotateZ(atan2(-0.4, 2));
            translate(0, -0.6, 0);
            fill(#6495ed);
            box(0.05, 0.8, 2.0);
        popMatrix();
    }

    public void draw() {
        pushMatrix();
        scale(.3, .3, .3);
        translate(0, WHEEL_RADIUS, 0);
        this.shafts();
        this.wheels();
        this.body();
        this.window();
        popMatrix();
    }
}
