#ifndef TORUS_H
#define TORUS_H

class Torus {
    private:
        float r1, r2;
    public:
        Torus();
        Torus(float r1, float r2);
        void setRadius1(float r);
        void setRadius2(float r);
        float getVolume();
        float getSurfaceArea();
};

#endif