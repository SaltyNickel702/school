#ifndef SPHERE_H
#define SPHERE_H

class Sphere {
    private: 
        float r;
    public:
        Sphere();
        Sphere(float radius);

        void setRadius(float rad);

        float getVolume();
        float getSurfaceArea();
};

#endif