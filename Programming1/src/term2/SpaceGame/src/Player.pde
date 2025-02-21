class Player extends GameObject {
    float speed = 400;


    double fireCool = 0;
    ArrayList<Weapon> equippedWeapons = new ArrayList<Weapon>();
    int weaponIndex = 0;

    Player () {
        tags.add("Player");

        x = 0;
        y = height/6;
        w = 60;
        h = 80;
        maxHealth = 200;
        health = 200;

        //Sprites
        //Jet
        Sprite jetMain = new Sprite("FighterJet",0,0,w,h);
        sprites.add(jetMain);

        //Flame
        Sprite jetFire = new Sprite("JetFire1",0,-45-7,-1,-1);
        jetFire.scale = 1.5;

        Animation jetFireTxtr = new Animation(2,0.75);
        jetFireTxtr.next = () -> {
            String nm = "JetFire" + (jetFireTxtr.frame + 1);
            jetFire.setImage(nm);
        };
        jetFire.anims.add(jetFireTxtr);

        Animation jetFireSz = new Animation(5,0.75);
        jetFireSz.next = () -> {
            jetFire.scale = 1.5 + (jetFireSz.frame)*0.1;
        };
        jetFire.anims.add(jetFireSz);

        sprites.add(jetFire);


        //Weapons
        equippedWeapons.add(new BaseLaser());
        // equippedWeapons.add(new Minigun());
        // equippedWeapons.add(new Nuke());


        //Logic
        Collider bounds = new Collider(-width/2,width/2,0,height/2);
        this.logic = () -> {
            if (getKey(KeyEvent.VK_W)) {
                y += speed * timeCoef();
            };
            if (getKey(KeyEvent.VK_S)) {
                y -= speed * timeCoef();
            }
            if (getKey(KeyEvent.VK_D)) {
                x += speed * timeCoef();
            }
            if (getKey(KeyEvent.VK_A)) {
                x -= speed * timeCoef();
            }

            //Check for bounds
            Collider c = collider();
            if (c.x1 < bounds.x1) x = bounds.x1 + w/2;
            if (c.x2 > bounds.x2) x = bounds.x2 - w/2;
            if (c.y1 < bounds.y1) y = bounds.y1 + h/2;
            if (c.y2 > bounds.y2) y = bounds.y2 - h/2;

            //Shooting
            if (getKey(KeyEvent.VK_SPACE) && fireCool == 0) {
                this.fire();
                fireCool = (double)1/equippedWeapons.get(weaponIndex).rate;
            } else {
                fireCool -= timeCoef();
                if (fireCool < 0) fireCool = 0;
            }


            //Health regen
            health+=5*timeCoef();
            if (health > maxHealth) health = maxHealth;
        };
        this.keypress = () -> {
            switch (keyCode) {
                case KeyEvent.VK_E:
                    weaponIndex--;
                    if (weaponIndex < 0) weaponIndex = equippedWeapons.size() - 1;
                    break;
                case KeyEvent.VK_Q:
                    weaponIndex++;
                    if (weaponIndex > equippedWeapons.size() - 1) weaponIndex = 0;
                    break;
            }
        };
    }

    void fire () {
        String[] tags = {"Player"};
        Weapon cw = equippedWeapons.get(weaponIndex);
        Projectile p = new Projectile(this.x+random(-5,5),this.y,new Vec2d(0,cw.speed),cw.clr,cw.w,cw.h,cw.dmg,tags);
        p.weaponType = cw;
        GameObjects.add(p);
    }

    void remove () {
        SCENE = new GameOver();
    }
}
