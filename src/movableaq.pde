abstract class MovableAquaticLife extends AquaticLife implements Movable {

    private PVector dir = new PVector(0, 1, 0);
    private float speed = 0.2;

    @Override
    public void move(Aquarium aq) {
        PVector p = this.getLocation();
        if(aq.hasFood()) {
            dir = aq.getFoodLocation();
            float d = dir.dist(p);
            dir.sub(p);
            dir.div(d);
        } else if(Math.random() < 0.05) {
            float theta = acos(dir.z);
            float phi = 0;
            if(cos(theta) > 1e-3) {
                phi = acos(dir.x / sin(theta));
            }

            theta += randomGaussian() / 10;
            phi += randomGaussian() / 10;

            dir.x = sin(theta) * cos(phi);
            dir.y = sin(theta) * sin(phi);
            dir.z = cos(theta);
        }
        p.add(PVector.mult(dir, speed));
        final int padding = 10;
        p.x = constrain(p.x, -aq.getWidth()/2 + padding, aq.getWidth()/2 - padding);
        p.y = constrain(p.y, aq.getSandHeight() + padding, aq.getWaterHeight() - padding);
        p.z = constrain(p.z, -aq.getDepth()/2 + padding, aq.getDepth()/2 - padding);
        this.setLocation(p.x, p.y, p.z);
    }
}
