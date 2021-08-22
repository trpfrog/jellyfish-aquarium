class Food extends MovableAquaticLife {
    @Override
    public void draw() {
        if(!isValid()) return;
        pushMatrix();
        PVector p = super.getLocation();
        translate(p.x, p.y, p.z);
        fill(#eedcb3);
        sphere(3);
        popMatrix();
    }

    private boolean valid = false;

    public boolean appear(float x, float y, float z) {
        if(this.isValid()) return false;
        valid = true;
        super.setLocation(x, y, z);
        return true;
    }

    public void eat() {
        valid = false;
    }

    public boolean isValid() {
        return valid;
    }

    @Override
    public void move(Aquarium aq) {
        if(!valid) return;
        PVector p = super.getLocation();
        if(p.y > aq.getWaterHeight()) {
            p.y -= 4;
        } else if (p.y > aq.getSandHeight()) {
            p.y -= 1;
        }
        super.setLocation(p.x, p.y, p.z);
    }
}