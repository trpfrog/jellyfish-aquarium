class Seaweed extends AquaticLife {

    private final float weedHeight = 20;
    private final float weedWidth = 5;
    private final float swingAmplitude = 1;
    private final int swingPoints = 4;

    @Override
    public void draw() {
        pushStyle();
        fill(#008000);
        beginShape(QUADS);
            final long t = millis();
            final float dy = 0.5;
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
                    * sin(ms / 8000.0 * TWO_PI)
                    * sqrt(1 - y / weedHeight);
    }
}
