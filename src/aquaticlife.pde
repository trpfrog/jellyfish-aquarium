abstract class AquaticLife extends Drawable {
    private PVector coordinate;

    public void setLocation(float x, float y, float z) {
        coordinate = new PVector(x, y, z);
    }

    public PVector getLocation() {
        return new PVector(coordinate.x, coordinate.y, coordinate.z);
    }

    public float getX() {
        return coordinate.x;
    }

    public float getY() {
        return coordinate.y;
    }

    public float getZ() {
        return coordinate.z;
    }
}
