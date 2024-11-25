class Collider {
    int x1,x2,y1,y2;

    Collider (int x1, int x2, int y1, int y2) {
        this.x1 = x1;
        this.x2 = x2;
        this.y1 = y1;
        this.y2 = y2;
    }

    Boolean test (Collider with) {
        if (x1 < with.x2 && x2 > with.x1) {
            if (y1 < with.y2 && y2 > with.y1) {
                return true;
            }
        }
        return false;
    }

    Boolean inside (Collider with) {
        if (x1 <= with.x2 && x1 >= with.x1) {
            if (x2 <= with.x2 && x2 >= with.x1) {
                if (y1 <= with.x2 && y1 >= with.y1) {
                    if (y2 <= with.y2 && y2 >= with.y1) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    Ray[] getSides () {
        Vector side = new Vec2d(0,y2-y1);
        Vector top = new Vec2d(x2-x1,0);
        Ray[] rays = {side.ray(x1,y1),side.ray(x2,y1),top.ray(x1,y1),top.ray(x1,y2)};
        return rays;
    }
}
