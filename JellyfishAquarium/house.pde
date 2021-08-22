class House extends Drawable {

    public House() {
    }

    private void base() {
        fill(#f5deb3);
        ArrayList<PVector> polys = new ArrayList<PVector>();
        polys.add(new PVector(-0.5, 0, 0));
        polys.add(new PVector(-0.5, 0, 1));
        polys.add(new PVector(0, 0, 1.5));
        polys.add(new PVector(0.5, 0, 1));
        polys.add(new PVector(0.5, 0, 0));
        pushMatrix();
            rotateX(-HALF_PI);
            pillar(1, polys);
        popMatrix();
    }

    private void roof() {
        fill(#4169e1);
        for(int i = 0; i < 2; i++) {
            pushMatrix();
                rotateY(PI * i);
                translate(0, 1.5, 0);
                rotateZ(PI / 4);
                translate(-0.5, 0, 0);
                box(1, 0.1, 1.2);
            popMatrix();
        }
        pushMatrix();
            translate(0, 1.5, 0);
            box(0.1, 0.1, 1.2);
        popMatrix();
    }

    private void chimney() {
        fill(#f5deb3);
        pushMatrix();
            translate(-0.35, 1.25, -0.25);
            box(0.2, 0.6, 0.2);
            translate(0, 0.3, 0);
            fill(#8b4513);
            box(0.22, 0.05, 0.22);
            fill(0);
            box(0.15, 0.051, 0.15);
        popMatrix();
    }

    private void windowParts() {
        pushMatrix();
            scale(0.2, 0.2, 0.2);
            rotateX(HALF_PI);
            int[] dx = {1, 0, -1, 0, 0, 0};
            int[] dz = {0, -1, 0, 1, 0, 0};
            fill(#00bfff);
            box(2, 0.05, 2);
            fill(#8b4513);
            for(int i = 0; i < 6; i++) {
                pushMatrix();
                    translate(dx[i], 0, dz[i]);
                    if(i % 2 == 1) rotateY(HALF_PI);
                    box(0.3, 0.3, 2.3);
                popMatrix();
            }
        popMatrix();
    }

    private void windows() {
        pushMatrix();
            for(int i = 0; i < 3; i++) {
                pushMatrix();
                    translate(0, 0.5, 0.5);
                    this.windowParts();
                popMatrix();
                rotateY(HALF_PI);
            }
        popMatrix();
    }

    private void doorParts() {
        pushMatrix();
            scale(0.2, 0.2, 0.2);

            pushMatrix();
                rotateX(-HALF_PI);
                translate(0, 0, 1.5);
                float[] dx = {1, 0, -1};
                float[] dz = {0, 1.5, 0};
                float[] l = {3, 2, 3};
                fill(#d2b48c);
                box(2, 0.05, 3);
                fill(#8b4513);
                for(int i = 0; i < 3; i++) {
                    pushMatrix();
                        translate(dx[i], 0, dz[i]);
                        if(i % 2 == 1) rotateY(HALF_PI);
                        box(0.3, 0.3, l[i] + (i % 2 == 1 ? 0.3 : 0));
                    popMatrix();
                }
            popMatrix();

            pushMatrix();
                translate(-0.5, 1.5, 0.1);
                sphere(0.15);
            popMatrix();

        popMatrix();
    }

    private void door() {
        pushMatrix();
            translate(-0.5, 0, 0);
            rotateY(-HALF_PI);
            this.doorParts();
        popMatrix();
    }

    public void draw() {
        pushMatrix();
        rotateY(HALF_PI);
        this.base();
        this.roof();
        this.chimney();
        this.windows();
        this.door();
        popMatrix();
    }
}