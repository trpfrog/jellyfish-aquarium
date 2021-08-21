CameraWork cameraWork = new CameraWork();

class CameraWork {
    private PVector prevCursorPosition = new PVector(0, 0);
    private PVector currentCursorPosition = new PVector(0, 0);
    private float x = 2, y = -287, ratio = 1;

    public void update() {
        if(prevCursorPosition.dist(currentCursorPosition) < 1) {
            rotateX(map(y, 0, height, TWO_PI, 0));
            rotateY(map(-x, 0, width, -PI, PI));
        } else {
            PVector res = PVector.sub(currentCursorPosition, prevCursorPosition);
            rotateX(map(y + res.y, 0, height, TWO_PI, 0));
            rotateY(map(-(x + res.x), 0, width, -PI, PI));
        }
        scale(ratio);
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
}

void mousePressed() {
    cameraWork.onMousePressed();
}

void mouseDragged() {
    cameraWork.onDragged();
}

void mouseReleased() {
    cameraWork.onMouseReleased();
}

void mouseWheel(MouseEvent e) {
    cameraWork.onMouseWheelMoved(e.getAmount());
}