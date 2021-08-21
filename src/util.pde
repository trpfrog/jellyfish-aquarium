public void texturedBox(float w, float h, float d, PImage texture) {
    ArrayList<PVector> list = new ArrayList<PVector>();
    int[] dx = {-1, 1, 1, -1};
    int[] dz = {-1, -1, 1, 1};
    for(int i = 0; i < 4; i++) {
        list.add(new PVector(dx[i] * w/2, 0, dz[i] * d/2));
    }
    pillar(h, list, texture, false);
}

public void cylinder(float h, float r, int vertices) {
    cylinder(h, r, vertices, null, null);
}

public void cylinder(float h, float r, int vertices, PImage texture) {
    cylinder(h, r, vertices, texture, null);
}

public void cylinder(float h, float r, int vertices, PImage texture, PImage topSurfaceTexture) {
    ArrayList<PVector> list = new ArrayList<PVector>();
    assert vertices > 0 : "Number of vertices must be greater than zero";
    for (int i = 0; i < vertices; i++) {
        float x = r * cos(TWO_PI / vertices * i);
        float z = r * sin(TWO_PI / vertices * i);
        list.add(new PVector(x, 0, z));
    }
    pillar(h, list, texture, topSurfaceTexture, true);
}

public void pillar(float h, ArrayList<PVector> troughSurface) {
    pillar(h, troughSurface, null, null, false);
}

public void pillar(float h, ArrayList<PVector> troughSurface, PImage texture, boolean wrapSide) {
    pillar(h, troughSurface, texture, null, wrapSide);
}

public void pillar(float h, ArrayList<PVector> troughSurface, PImage texture, PImage topSurfaceTexture, boolean wrapSide) {

    float x_max = Float.MIN_VALUE, z_max = Float.MIN_VALUE, 
          x_min = Float.MAX_VALUE, z_min = Float.MAX_VALUE;

    for (PVector p : troughSurface) {
        x_max = Math.max(x_max, p.x);
        z_max = Math.max(z_max, p.z);
        x_min = Math.min(x_min, p.x);
        z_min = Math.min(z_min, p.z);
    }

    beginShape();
        if(topSurfaceTexture != null) {
            texture(topSurfaceTexture);
            textureMode(NORMAL);
        } else if(texture != null) {
            texture(texture);
            textureMode(NORMAL);
        }
        for (PVector p : troughSurface) {
            float u = (p.x - x_min) / (x_max - x_min);
            float v = (p.z - z_min) / (z_max - z_min);
            vertex(p.x, p.y - h / 2, p.z, u, v);
        }
    endShape(CLOSE);
    
    beginShape();
        if(topSurfaceTexture != null) {
            texture(topSurfaceTexture);
            textureMode(NORMAL);
        } else if(texture != null) {
            texture(texture);
            textureMode(NORMAL);
        }
        for (PVector p : troughSurface) {
            float u = (p.x - x_min) / (x_max - x_min);
            float v = (p.z - z_min) / (z_max - z_min);
            vertex(p.x, p.y + h / 2, p.z, u, v);
        }
    endShape(CLOSE);
    
    beginShape(QUADS);
        if(texture != null) {
            texture(texture);
            textureMode(NORMAL);
        }
        for(int i = 0; i < troughSurface.size(); i++) {
            float dv = 1.0f / troughSurface.size();

            int j = (i + 1) % troughSurface.size();
            PVector p = troughSurface.get(i);
            PVector q = troughSurface.get(j);
            if(wrapSide) {
                vertex(p.x, p.y - h / 2, p.z, i * dv, 0);
                vertex(q.x, q.y - h / 2, q.z, i * dv, 1);
                vertex(q.x, q.y + h / 2, q.z, (i + 1) * dv, 1);
                vertex(p.x, p.y + h / 2, p.z, (i + 1) * dv, 0);
            } else {
                vertex(p.x, p.y - h / 2, p.z, 0, 0);
                vertex(q.x, q.y - h / 2, q.z, 0, 1);
                vertex(q.x, q.y + h / 2, q.z, 1, 1);
                vertex(p.x, p.y + h / 2, p.z, 1, 0);
            }
        }
    endShape();
}