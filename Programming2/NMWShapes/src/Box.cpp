#include "Box.h"

Box::Box() {
    width = 0;
    length = 0;
    height = 0;
}
Box::Box(float w, float l, float h) {
    length = l;
    width = w;
    height = h;
}
void Box::setLength(float l) {length = l;}
void Box::setWidth(float w) {width = w;}
void Box::setHeight(float h) {height = h;}
float Box::getVolume() {return width*length*height;}
float Box::getSurfaceArea() {return 2 * (width*length + width*height + height*length);}