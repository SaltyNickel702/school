class Sprite {
    float dx,dy;
    int w,h;
    PImage img;
    String imgName;
    float scale = 1;
    color tnt = #ffffff;

    boolean cameraView = false;

    ArrayList<Animation> anims = new ArrayList<Animation>();

    Sprite (String name, int x, int y, int w, int h) {
        setImage(name);
        dx = x;
        dy = y;
        this.w = w;
        this.h = h;
    }

    void display (int cx, int cy) {
        int[] dCrd = new int[2];
        if (cameraView) {
            dCrd[0] = (int)(cx + dx);
            dCrd[1] = (int)(cy + dy);
        } else {
            dCrd = CAMERA.sceneToCamera((int)(cx + dx), (int)(cy + dy));
        }

        if (!physics.isInterrupted()) {
            for (Animation a : anims) {
                a.tick();
            }

            try {
                if (physicsRunning) tick.run();
            } catch (NullPointerException e) {}
        }
        
        try {
            tint(tnt);
            image(img,dCrd[0],dCrd[1],(w == -1) ? img.width * scale : w, (h == -1) ? img.height * scale : h);
        } catch (NullPointerException e) {}
    }
    Runnable tick;

    void setImage (String name) {
        Loop:for (ImageData Img : ImageCache) {
            if (Img.name.equals(name)) {
                imgName = name;
                img = Img.img;
                return;
            }
        }
    }
}
