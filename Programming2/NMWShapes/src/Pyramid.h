#ifndef PYRAMID_H
#define PYRAMID_H

class Pyramid {
    private:
        float width, slantHeight;
    public:
        Pyramid();
        Pyramid(float w, float sltH);
        
        void setWidth (float w);
        void setSlantHeight (float h);

        float getVolume ();
        float getSurfaceArea ();
};

#endif