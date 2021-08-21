public PImage SAND_TEXTURE, MARBLE_TEXTURE, FLOOR_TEXTURE;

void setupTextures() {
    SAND_TEXTURE = loadImage("sand.jpg");
    MARBLE_TEXTURE = loadImage("marble.jpg");
    FLOOR_TEXTURE = loadImage("floor.jpg");
}

void repeatTile(PVector start, float w, float d, PImage texture, final int tileSize) {
    pushMatrix();
        translate(start.x, start.y, start.z);
        final float maxW = w;
        final float maxD = d;
        beginShape(QUADS);
            texture(texture);
            textureMode(NORMAL);
            for(float i = 0; i < maxW; i += tileSize) {
                for(float j = 0; j < maxD; j += tileSize) {
                    float i2 = i + tileSize;
                    float j2 = j + tileSize;
                    float u = 1, v = 1;
                    if(i2 > maxW) {
                        i2 = maxW;
                        u = (float)(maxW - i) / tileSize;
                    }
                    if(j2 > maxD) {
                        j2 = maxD;
                        v = (float)(maxD - j) / tileSize;
                    }
                    vertex(i, 0, j, 0, 0);
                    vertex(i, 0, j2, 0, v);
                    vertex(i2, 0, j2, u, v);
                    vertex(i2, 0, j, u, 0);
                }
            }
        endShape();
    popMatrix();
}
