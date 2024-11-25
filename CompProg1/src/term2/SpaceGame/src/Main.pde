import java.awt.event.KeyEvent;

ArrayList<ImageData> ImageCache = new ArrayList<ImageData>();
ArrayList<GameObject> GameObjects = new ArrayList<GameObject>();

Camera CAMERA;
PFont FONT;

void setup () {
    size(675, 900);
    pixelDensity(1);
    frameRate(60);

    rectMode(CENTER);
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
    smooth(0);
    
    CAMERA = new Camera(0, height/2);

    FONT = createFont("Monospace.ttf",30);
    textFont(FONT);

    //import images
    ImageCache.add(new ImageData("FighterJet.png", "FighterJet"));
    ImageCache.add(new ImageData("JetFire1.png", "JetFire1"));
    ImageCache.add(new ImageData("JetFire2.png", "JetFire2"));
    ImageCache.add(new ImageData("Stars.png", "Stars"));
    ImageCache.add(new ImageData("BaseEnemy.png","BaseEnemy"));
    ImageCache.add(new ImageData("Explosion1.png","Explosion1"));
    ImageCache.add(new ImageData("Explosion2.png","Explosion2"));
    ImageCache.add(new ImageData("Explosion3.png","Explosion3"));
    ImageCache.add(new ImageData("UI.png","UI"));
    ImageCache.add(new ImageData("UIcircle.png","UIcircle"));

    ImageCache.add(new ImageData("TurretIconYellow.png","Minigun"));
    ImageCache.add(new ImageData("TurretIconRed.png","Nuke"));
    ImageCache.add(new ImageData("TurretIconGreen.png","BaseLaser"));


    startPhysics();
    physics.start();
    // physics.interrupt();

    SCENE = new MainMenu();
}


//MENUES and Scene
Scene SCENE;


//RENDERING
void draw () {
    background(0);
    try {
        for (int i = 1; i < GameObjects.size(); i++) {
            GameObjects.get(i).display();
        }
        if (GameObjects.size() > 0) GameObjects.get(0).display(); 
    } catch (NullPointerException e) {}
    SCENE.display();
}


//PHYSICS
int tickRate = 60;
long ticks = 0;
double timeFlow = 1;
int score = 0;
double timeCoef () {
    return (double)1/tickRate * timeFlow;
}
ArrayList<GameObject> removeList = new ArrayList<GameObject>();
Thread physics;
Boolean physicsRunning = true;
void startPhysics () {
    physics = new Thread() {
        public void run () {
            while (true) {
                if (physicsRunning) {
                    ticks++;

                    for (int i = 0; i < GameObjects.size(); i++) {
                        try {
                            GameObjects.get(i).tick();
                            GameObjects.get(i).logic.run();
                        }
                        catch (NullPointerException e) {
                        }
                    }


                    for (; removeList.size() > 0; ) {
                        GameObjects.removeIf((n) -> n == removeList.get(0));
                        removeList.remove(0);
                    }
                }

                try {
                    SCENE.tick.run();
                } catch (NullPointerException e) {}
                
                try {
                    Thread.sleep(1000/tickRate);
                } catch (InterruptedException e) {}
            }
        }
    };
}
void physicsKeyStroke () {
    try {
        if (!physics.isInterrupted()) {
        for (int i = 0; i < GameObjects.size(); i++) {
            try {
                GameObjects.get(i).keypress.run();
            } catch (NullPointerException e) {}
        }
    }
    } catch (NullPointerException e) {}
}


//KEY HANDLER
boolean keysEnabled = true;
ArrayList<Integer> keysDown = new ArrayList<Integer>();
void keyPressed () {
    if (!getKey(keyCode)) {
        physicsKeyStroke();
        try {
            SCENE.keypress.run();
        } catch (NullPointerException e) {}
    }
    keysDown.removeIf((n) -> n == keyCode);
    keysDown.add(keyCode);
}
void keyReleased () {
    keysDown.removeIf((n) -> n == keyCode);
}
Boolean getKey (int key) {
    return keysDown.contains(key);
}
void mousePressed () {
    for (int i = 0; i < SCENE.menues.size(); i++) {
        SCENE.menues.get(i).interact();
    }
}


//DEBUG
Debug DEBUG = new Debug();
