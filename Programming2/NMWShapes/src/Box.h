#ifndef BOX_H
#define BOX_H

class Box {
    private:
        float length, width, height;
    public:
        Box();
        Box(float w, float l, float h);
        
        void setLength (float l);
        void setWidth (float w);
        void setHeight (float h);

        float getVolume ();
        float getSurfaceArea ();
};

#endif