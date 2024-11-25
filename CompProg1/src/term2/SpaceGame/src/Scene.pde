class Scene {
    ArrayList<Wave> waves = new ArrayList<Wave>();
    ArrayList<Menu> menues = new ArrayList<Menu>();

    Runnable keypress;
    Runnable tick;

    boolean renderGame = true;

    Scene () {
        GameObjects.removeIf((n) -> true);
    }

    void display () {
        for (int i = menues.size() - 1; i > -1; i--) {
            menues.get(i).display();
        }
    }
}
class Wave {
    ArrayList<Grid> grids = new ArrayList<Grid>();

    void start () {

    }
}
class Grid {
    double x, y;
    int w,h;
    int spacer;

    ArrayList<Enemy> enemies = new ArrayList<Enemy>();

    Grid (double cx, double cy, int gw, int gh, int enemySpace, String enemyType) {
        x = cx;
        y = cy;
        w = gw;
        h = gh;
        spacer = enemySpace;

        for (int i = 0; i < w*h; i++) {
            Enemy e = new Enemy(0,0,enemyType);
            int column = i%w;
            int row = (int)Math.floor(h/i);
            enemies.add(e);
        }
        updateGrid();
    }

    void updateGrid () {
        
    }
}


//Menues
class MainMenu extends Scene {
    MainMenu () {
        Menu menu = new Menu();
        Menu about = new Menu();

		menu.text.add(new TextElement("Space Game", width/2, height/4, 50, #ffffff));
        menu.text.add(new TextElement("By Niko Wolf", width/2, height/3, 25, #ffffff));

		menu.text.add(new TextElement("Start", width/2,height/2,40,#ffffff));
		menu.rects.add(new Rect(width/2,height/2,200,100, 10, #0000ff));
		menu.buttons.add(new Button(width/2,height/2,200,100,() -> {
			SCENE = new LevelPatch();
		}));
        menu.text.add(new TextElement("About", width/2,height/2+125,40,#ffffff));
		menu.rects.add(new Rect(width/2,height/2+125,200,100, 10, #0000ff));
		menu.buttons.add(new Button(width/2,height/2+125,200,100,() -> {
			about.hidden = false;
            menu.hidden = true;
		}));

        menues.add(menu);


        about.text.add(new TextElement("Health is displayed as color of UI", width/2, height/4, 25, #ffffff));
        about.text.add(new TextElement("WASD to move. Space to fire.\nE and Q to rotate weapon wheel", width/2, height/4+60, 25, #ffffff));
        about.text.add(new TextElement("Turret Powerups give new weapons,\nthe minigun (yellow), and the nuke (red)", width/2, height/4 + 150, 25, #ffffff));
        about.sprites.add(new Sprite("BaseLaser",0,height/2,-1,-1));
        about.sprites.get(0).scale = 4;

        about.text.add(new TextElement("Back", width/2,height/2+100,40,#ffffff));
		about.rects.add(new Rect(width/2,height/2+100,120,75, 10, #ff0000));
		about.buttons.add(new Button(width/2,height/2+100,75,50,() -> {
			about.hidden = true;
            menu.hidden = false;
		}));

        about.hidden = true;
        menues.add(about);


        GameObjects.add(new Player());
        Player p = (Player)GameObjects.get(0);
        Animation anim = new Animation(5,6);
        p.sprites.get(0).anims.add(anim);
        Boolean atBottom = false;
        p.logic = () -> {
            if (anim.frame >= 2) {
                p.y+= height/2.5*timeCoef();
            } else {
                p.y = height/4;
            }
            if (p.y > height + 100) p.y = -100;
        };
    }  
}
class GameOver extends Scene {
    GameOver () {
        Menu menu = new Menu();

        menu.text.add(new TextElement("Game Over", width/2, height/4, 50, #ffffff));
        menu.text.add(new TextElement("Score:" + score, width/2, height/3, 25, #ffffff));
		menu.text.add(new TextElement("Restart", width/2,height/2,40,#ffffff));
		menu.rects.add(new Rect(width/2,height/2,200,100, 10, #ff0000));
		menu.buttons.add(new Button(width/2,height/2,200,100,() -> {
			SCENE = new LevelPatch();
            physicsRunning = true;
            score = 0;
		}));

        menues.add(menu);

        physicsRunning = false;
    }
}


//Levels
class Level extends Scene {
    Player player;
    Runnable tick2;
    Level () {
        Menu pause = new Menu();
        pause.hidden = true;
        pause.rects.add(new Rect(width/2,height/2,width,height,0,color(0,0,0,127)));
        pause.text.add(new TextElement("Paused",width/2,height/2,60,#ffffff));
        menues.add(pause);

        
        Menu ui = new Menu();

        Sprite back = new Sprite("UI",0,height/2,-1,-1);
        back.scale = 9;
        ui.sprites.add(back);

        Sprite wpnWl = new Sprite("UIcircle",(int)(-width*0.35),(int)(height*0.1),-1,-1);
        wpnWl.scale = 7;
        ui.sprites.add(wpnWl);

        TextElement healthDebug = new TextElement("",width/2,height - 50,30,#00ff00);
        ui.text.add(healthDebug);

        TextElement scr = new TextElement(score + "",width*7/8,height - 50,30,#ffffff);
        ui.text.add(scr);

        menues.add(ui);


        player = new Player();
        GameObjects.add(player);
        GameObjects.add(new Background("Stars",2.75,15));


        keypress = () -> {
            switch (keyCode) {
                case KeyEvent.VK_P:
                    if (pause.hidden) {
                        pause.hidden = false;
                        physicsRunning = false;
                    } else {
                        pause.hidden = true;
                        physicsRunning = true;
                    }
                    break;
            }
        };

        ArrayList<Sprite> wpns = new ArrayList<Sprite>();
        tick = () -> {
            //UI Tint based on health
            float frac = (float)player.health/player.maxHealth;
            int r = (int)((1 - frac)*255*1.1);
            int g = (int)(frac*255);
            int b = (int)(frac*255*1.2);
            
            back.tnt = color(r,g,b);
            wpnWl.tnt = color(r,g,b);

            //Health Debug
            if (DEBUG.showHealth) {
                healthDebug.txt = (int)player.health + "";
            } else {
                healthDebug.txt = "";
            }

            //Weapon Wheel
            Wloop: for (Weapon w : player.equippedWeapons) {
                for (Sprite s : wpns) {
                    if (s.imgName.equals(w.name)) {
                        continue Wloop;
                    }
                }
                Sprite s = new Sprite(w.name,0,0,-1,-1);
                s.scale = 2;
                wpns.add(s);
                ui.sprites.add(s);
            }
            for (int i = 0; i < wpns.size(); i++) {
                int index = (i - player.weaponIndex) % wpns.size();
                Sprite s = wpns.get(i);
                s.dx = (float)(6*9*Math.cos(Math.PI/4 - index*Math.PI*2/wpns.size()) - width*0.35);
                s.dy = (float)(6*9*Math.sin(Math.PI/4 - index*Math.PI*2/wpns.size()) + height*0.1);
            }

            //Score text
            scr.txt = score + "";
        };
    }
}

class Demo extends Level {
    Demo () {
        GameObject dummy = new GameObject();
        dummy.w = 100;
        dummy.h = 100;
        dummy.x = 0;
        dummy.y = 500;
        // GameObjects.add(dummy);

        String[] ignored = {"player"};
        Projectile p = new Projectile(10,30,new Vec2d(0,500), #000000, 1, 50, 10, ignored);
        // p.logic = () -> {};
        // GameObjects.add(p);

        GameObjects.add(new Enemy(0,500,"base"));
        GameObjects.add(new Enemy(100,500,"base"));
        GameObjects.add(new Enemy(-100,500,"base"));
    }
}
int time = 3000;
class LevelPatch extends Level {
    LevelPatch () {
        addEnemy();
    }
    void addEnemy () {
        if (physicsRunning) {
            Timer t = new Timer(time,() -> {
                time*=0.95;
                if (time < 360) time = 1000;
                addEnemy();
            });
        }
        float rx = random(0,width-50)-(width-50)/2;
        Enemy e = new Enemy(rx,height,"base");
        GameObjects.add(e);
    }
}
