class Powerup extends GameObject {
    String type;
    Powerup (String type) {
        x = random(0,width-50) - (width-50)/2;
        y = height;

        this.type = type;

        Sprite s = new Sprite(type,0,0,-1,-1);
        s.scale = 4;
        sprites.add(s);

        logic = () -> {
            y-=25*timeCoef();
            Player p = (Player)GameObjects.get(0);

            for (Weapon w : p.equippedWeapons) {
                if (w.name.equals(type)) remove();
            }

            if (collider().test(p.collider())) {
                remove();
                if (type == "Nuke") {
                    p.equippedWeapons.add(new Nuke());
                } else {
                    p.equippedWeapons.add(new Minigun());
                }
            }
        };
    }
}
