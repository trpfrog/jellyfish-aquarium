class Seaweed extends AquaticLife {

    private final float weedHeight;
    private final float weedWidth;
    private final float swingAmplitude;
    private final int swingPoints;
    private final float swingPeriodMillis;
    private color weedColor = 0;
    private boolean colorSet = false;
    private long initialPhase = 0;

    private float thickness = 0.3;

    public Seaweed() {
        this(5, 20 + randomGaussian());
    }

    public Seaweed(float w, float h) {
        this(w, h, 1, 4, 16000);
    }

    public Seaweed(float w, float h, float swingAmp, int swingPoints, float swingPeriodMillis) {
        this.weedHeight = h;
        this.weedWidth = w;
        this.swingAmplitude = swingAmp;
        this.swingPoints = swingPoints;
        this.swingPeriodMillis = swingPeriodMillis;
    }

    @Override
    public void draw() {
        pushStyle();
        if(colorSet) {
            fill(weedColor);
        }
        final long t = millis() + initialPhase;

        if(thickness < 0.001) {
            drawLeaf(t);
        } else {
            pushMatrix();
                rotateX(sin(t / swingPeriodMillis * 3) * 0.05f);
                pushMatrix();
                    drawLeaf(t);
                    translate(0, 0, thickness);
                    drawLeaf(t);
                popMatrix();
                pushMatrix();
                    pushMatrix();
                        translate(0, 0, thickness);
                        drawSide(-t);
                    popMatrix();
                    rotateY(PI);
                    drawSide(t);
                popMatrix();
            popMatrix();
        }
        popStyle();
    }

    private void drawLeaf(final long t) {
        beginShape(QUADS);
            final float dy = 0.4;
            for (float y = 0; y + dy < weedHeight; y += dy) {
                float x1 = 0.5 * getWidthAt(y);
                float x2 = 0.5 * getWidthAt(y + dy);
                float z1 = getDepthAt(y, t);
                float z2 = getDepthAt(y + dy, t);
                vertex(x1, y, z1);
                vertex(x2, y + dy, z2);
                vertex(-x2, y + dy, z2);
                vertex(-x1, y, z1);
            }
        endShape();
    }

    private void drawSide(final long t) {
        pushMatrix();
            rotateY(HALF_PI);
            beginShape(QUADS);
                final float dy = 0.2;
                for (float y = 0; y + dy < weedHeight; y += dy) {
                    float z1 = 0.5 * getWidthAt(y);
                    float z2 = 0.5 * getWidthAt(y + dy);
                    float x1 = getDepthAt(y, t);
                    float x2 = getDepthAt(y + dy, t);
                    vertex(x1, y, z1);
                    vertex(x1 + thickness, y, z1);
                    vertex(x2 + thickness, y + dy, z2);
                    vertex(x2, y + dy, z2);
                }
            endShape();
        popMatrix();
    }

    private float getWidthAt(float y) {
        return weedWidth * sqrt(1 - y / weedHeight);
    }

    private float getDepthAt(float y, long ms) {
        float period = weedHeight / (swingPoints + 1);
        return swingAmplitude 
                    * sin(y / period * TWO_PI) 
                    * sin(ms / swingPeriodMillis * 2 * TWO_PI)
                    * sqrt(1 - y / weedHeight);
    }

    public void setColor(color c) {
        colorSet = true;
        weedColor = c;
    }

    public void setThickness(float thickness) {
        this.thickness = thickness;
    }

    public void setInitalPhase(float theta) {
        this.initialPhase = (long)(theta / (4 * PI) * swingPeriodMillis);
    }
}
