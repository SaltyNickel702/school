class GameObject {
    ArrayList<String> tags = new ArrayList<String>();

    double x,y;
    float health;
    float maxHealth;
    Boolean invincible = false;
    Boolean ignore = false;
    
    int w,h;
    Collider collider () {
        return new Collider((int)x-w/2,(int)x+w/2,(int)y-h/2,(int)y+h/2);
    }

    Runnable logic;
    Runnable keypress;
    Runnable death;

    ArrayList<Sprite> sprites = new ArrayList<Sprite>();

    void display () {
        for (Sprite sp : sprites) {
            sp.display((int)x,(int)y);
        }

        
        //Debug Renderer
        if (DEBUG.showObjCenter) {
            fill(#ff0000);
            noStroke();
            int[] camCoor = CAMERA.sceneToCamera((int)x,(int)y);
            ellipse(camCoor[0],camCoor[1],10,10);
        }
        if (DEBUG.showColliders) {
            try {
                Collider c = collider();
                Ray[] rays = c.getSides();
                for (Ray r : rays) {
                    r.debugDisplay();
                }
            } catch (NullPointerException e) {}
        }
    }

    void tick () {
        for (int i = 0; i < GameObjects.size(); i++) {
            GameObject obj = GameObjects.get(i);
            if (obj == this) continue;


            //Check for collision w/ projectile
            if (!(this instanceof Projectile) && !invincible && !ignore) {
                if (obj instanceof Projectile) {
                    Projectile p = (Projectile) obj;
                    for (String s : p.ignoredTags) {
                        if (tags.contains(s)) continue;
                    }
                    double d = distanceTo(p);
                    try {
                        if (p.hits(this)) {
                            p.remove();
                            damage(p.dmg);

                            if (p.weaponType instanceof Nuke) {
                                NukeL: for (int j = 0; j < GameObjects.size(); j++) {
                                    GameObject o = GameObjects.get(j);
                                    if (o.invincible || o.ignore) continue;
                                    for (String s : p.ignoredTags) {
                                        if (o.tags.contains(s)) continue NukeL;
                                    }
                                    if (distanceTo(o) > 500) continue;
                                    o.damage(100000);
                                }
                            }

                            //Explosion Decal
                            GameObject eDecal = new GameObject();
                            eDecal.x = x;
                            eDecal.y = y;
                            eDecal.invincible = true;
                            eDecal.ignore = true;

                            int decalNum = (int)random(1.5,2.5);
                            if (health <= 0) decalNum = 3;
                            Sprite decal = new Sprite("Explosion" + 3,0,0,-1,-1);
                            final int scl = health <= 0 ? 4 : 2;
                            decal.scale = scl;

                            Animation texture = new Animation(5,(health <= 0 ? 0.5 : 0.25));
                            texture.next = () -> {
                                decal.setImage("Explosion" + (int)random(1.5,2.5));
                                decal.scale = scl - texture.frame * scl / 6;
                            };
                            decal.anims.add(texture);

                            Timer expire = new Timer((health <= 0 ? 500 : 250),() -> {
                                eDecal.remove();
                            });

                            eDecal.sprites.add(decal);
                            GameObjects.add(eDecal);

                        }
                    } catch (NullPointerException e) {}
                }
            }
        }
    }

    void remove () {
        removeList.add(this);
        try {
            death.run();
        } catch (NullPointerException e) {}
    }

    void damage (int d) {
        health-= d;
        if (health <= 0) {
            remove();
        }
    }

    double distanceTo (GameObject obj) {
        return Math.sqrt(Math.pow(obj.x-x,2) + Math.pow(obj.y-y,2));
    }
}
