abstract class MovableAquaticLife extends AquaticLife implements Movable {

    private PVector dir = new PVector(0, 1, 0);
    private float speed = 0.1;

    @Override
    public void move(Aquarium aq) {
        PVector p = this.getLocation();
        if(aq.getFood().isValid()) {
            PVector foodLocation = aq.getFood().getLocation();
            float xzDist = (float)Math.hypot(
                foodLocation.x - p.x, foodLocation.z - p.z
            );
            // println(xzDist + " " + abs(foodLocation.y - p.y));
            if(xzDist < 2 && 0 < p.y - foodLocation.y && p.y - foodLocation.y < 15) {
                aq.getFood().eat();
            }
            dir = PVector.sub(foodLocation, p);
        } else if(Math.random() < 0.2) {
            float theta = acos(dir.z);
            float phi = 0;
            if(Math.hypot(dir.x, dir.y) > 1e-2) {
                phi = (dir.y / abs(dir.y)) * acos(dir.x / (float)Math.hypot(dir.x, dir.y));
            }

            theta += randomGaussian() / 10;
            phi += randomGaussian() / 10;

            if(!Float.isNaN(theta) && !Float.isNaN(phi)) {
                dir.x = sin(theta) * cos(phi);
                dir.y = sin(theta) * sin(phi);
                dir.z = cos(theta);
            }
        }
        dir.normalize();
        p.add(PVector.mult(dir, speed));
        final int padding = 10;

        p.x = constrain(p.x, -aq.getWidth()/2 + padding, aq.getWidth()/2 - padding);
        p.y = constrain(p.y, aq.getSandHeight() + padding, aq.getWaterHeight() - padding);
        p.z = constrain(p.z, -aq.getDepth()/2 + padding, aq.getDepth()/2 - padding);
        this.setLocation(p.x, p.y, p.z);
    }
}
