CameraWork cameraWork = new CameraWork();

class CameraWork {
    private PVector prevCursorPosition = new PVector(0, 0);
    private PVector currentCursorPosition = new PVector(0, 0);
    private float x = 2, y = -287, ratio = 1;
    private float tx = 0, ty = 0, tz = 0;
    private boolean isKeyPressed = false;

    public CameraWork() {
        reset();
    }

    public void update() {
        translate(tx, ty, tz);
        if(prevCursorPosition.dist(currentCursorPosition) < 1) {
            rotateX(map(y, 0, height, TWO_PI, 0));
            rotateY(map(-x, 0, width, -PI, PI));
        } else {
            PVector res = PVector.sub(currentCursorPosition, prevCursorPosition);
            rotateX(map(y + res.y, 0, height, TWO_PI, 0));
            rotateY(map(-(x + res.x), 0, width, -PI, PI));
        }
        scale(ratio);
        if(isKeyPressed) whileKeyPressed();
    }

    private void resetPosition() {
        prevCursorPosition.set(mouseX, mouseY);
        currentCursorPosition.set(mouseX, mouseY);
    }

    public void onMousePressed() {
        resetPosition();
    }

    public void onDragged() {
        currentCursorPosition.set(mouseX, mouseY);
    }

    public void onMouseReleased() {
        PVector res = PVector.sub(currentCursorPosition, prevCursorPosition);
        x += res.x;
        y += res.y;
        x %= width;
        y %= height;
        resetPosition();
    }

    public void onMouseWheelMoved(float f) {
        f /= -1000;
        ratio = constrain(ratio + f, 0.1, 10);
    }

    private void whileKeyPressed() {
        if (key == 'j' || key == 'J') {
            aquarium.accelerateJellyfish(-0.1);
        } else if(key == 'k' || key == 'K') {
            aquarium.accelerateJellyfish(0.1);
        } if(key == 'w' || key == 'W') {
            translateCamera(0, 4, 0);
        } else if(key == 's' || key == 'S') {
            translateCamera(0, -4, 0);
        } else if(key == 'a' || key == 'A') {
            translateCamera(4, 0, 0);
        } else if(key == 'd' || key == 'D') {
            translateCamera(-4, 0, 0);
        }
    }

    public void translateCamera(float dx, float dy, float dz) {
        final int limit = 10000;
        tx = constrain(tx + dx, -limit, limit);
        ty = constrain(ty + dy, -limit, limit);
        tz = constrain(tz + dz, -limit, limit);
    }

    public void setKeyPressed(boolean b) {
        isKeyPressed = b;
    }

    public void reset() {
        tx = ty = tz = 0;
        x = 2;
        y = -287;
        ratio = 1;
        isKeyPressed = false;
    }
}

void mousePressed(MouseEvent e) {
    if(e.getButton() == LEFT) {
        cameraWork.onMousePressed();
    } else if(e.getButton() == RIGHT) {
        final int padding = 20;
        aquarium.getFood().appear(
            random(-aquarium.getWidth()/2 + padding, aquarium.getWidth()/2 - padding),
            aquarium.getHeight() * 2,
            random(-aquarium.getDepth()/2 + padding, aquarium.getDepth()/2 - padding)
        );
    } else if(e.getButton() == CENTER) {
        cameraWork.reset();
    }
}

void mouseDragged(MouseEvent e) {
    if(e.getButton() == LEFT) cameraWork.onDragged();
}

void mouseReleased(MouseEvent e) {
    if(e.getButton() == LEFT) cameraWork.onMouseReleased();
}

void mouseWheel(MouseEvent e) {
    cameraWork.onMouseWheelMoved(e.getAmount());
}

void keyPressed() {
    cameraWork.setKeyPressed(true);
}

void keyReleased() {
    cameraWork.setKeyPressed(false);
}