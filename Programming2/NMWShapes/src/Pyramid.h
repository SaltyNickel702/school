#ifndef PYRAMID_H
#define PYRAMID_H

class Pyramid {
    private:
        float width, length, height;
    public:
        Pyramid();
        Pyramid(float w, float l, float h);
        
        void setWidth (float w);
        void setLength (float l);
        void setHeight (float h);

        float getVolume ();
        float getSurfaceArea ();
};

#endif