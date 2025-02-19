#include "Pyramid.h"
#include <cmath>

Pyramid::Pyramid() {
    width = 0;
    length = 0;
    height = 0;
}
Pyramid::Pyramid(float w, float l, float h) {
    width = w;
    length = l;
    height = h;
}
void Pyramid::setWidth(float w) {width = w;}
void Pyramid::setLength(float l) {length = l;}
void Pyramid::setHeight(float h) {height = h;}
float Pyramid::getVolume() {return (width*length*height)/3;}
float Pyramid::getSurfaceArea() {return (width*length) + 2*(width*sqrt(pow(length/2,2) + pow(height,2))) + 2*(height*sqrt(pow(width/2,2) + pow(height,2)));}