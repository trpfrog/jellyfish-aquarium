abstract class Drawable {
    public void draw(float ratio) {
        pushMatrix();
        scale(ratio);
        draw();
        popMatrix();
    }

    abstract public void draw();
}
