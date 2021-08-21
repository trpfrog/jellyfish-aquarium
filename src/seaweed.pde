class Seaweed extends AquaticLife {

    private final float weedHeight;
    private final float weedWidth;
    private final float swingAmplitude;
    private final int swingPoints;
    private final float swingPeriodMillis;
    private color weedColor = 0;
    private boolean colorSet = false;

    public Seaweed() {
        this(5, 20);
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
        beginShape(QUADS);
            final long t = millis();
            final float dy = 0.2;
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
        popStyle();
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
}
