class Enemy extends GameObject {
    Weapon weapon;
    double weaponCooldown;

    Enemy (double X, double Y, String type) {
        x = X;
        y = Y;
        
        this.tags.add("enemy");

        switch (type) {
            case "base":
                w = 50;
                h = 50;
                health = 50;
                weapon = new EnemyLaser();

                logic = () -> {
                    if (weaponCooldown == 0) {
                        this.fire();
                        weaponCooldown = (double)1/weapon.rate;
                    } else {
                        weaponCooldown -= timeCoef();
                        if (weaponCooldown < 0) weaponCooldown = 0;
                    }
                    y-=50*timeCoef();
                };

                Sprite s = new Sprite("BaseEnemy",0,0,-1,-1);
                s.scale = 2.5;
                sprites.add(s);

                Animation anim = new Animation(8,1);
                anim.next = () -> {
                    s.dy = (-Math.abs(anim.frame-4)+4)*3;
                };
                s.anims.add(anim);

                break;
        }
        death = () -> {
            score += 23;
            float r = random(0,25);
            if (r > 23.5) {
                Player p = (Player)GameObjects.get(0);
                if (p.equippedWeapons.size() == 1) GameObjects.add(new Powerup("Minigun"));
                if (p.equippedWeapons.size() == 2) GameObjects.add(new Powerup("Nuke"));
            }
        };
    }

    void fire () {
        String[] ignored = {"enemy"};
        Projectile p = new Projectile(x, y, new Vec2d(0,-weapon.speed), weapon.clr, weapon.w, weapon.h, weapon.dmg, ignored);
        GameObjects.add(p);
    }
}
