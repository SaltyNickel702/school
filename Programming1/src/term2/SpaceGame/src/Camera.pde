class Camera {
    int x, y;

    Camera (int x, int y) {
        this.x = x;
        this.y = y;
    }

    int[] sceneToCamera (int x, int y) {
        int nx = width/2 + (x - this.x);
        int ny = height/2 + -(y - this.y);
        int[] coords = {nx,ny};
        return coords;
    }
    int[] cameraToScene (int x, int y) {
        int nx = x - width/2 + this.x;
        int ny = -(y - height/2) + this.y;
        int[] coords = {nx,ny};
        return coords;
    }
}
