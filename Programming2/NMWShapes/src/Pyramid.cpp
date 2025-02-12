#include "Pyramid.h"
#include <cmath>

Pyramid::Pyramid() {
    this->width = 0;
    this->slantHeight = 0;
}
Pyramid::Pyramid(float w, float sltH) {
    width = w;
    slantHeight = sltH;
}
void Pyramid::setWidth(float w) {width = w;}
void Pyramid::setSlantHeight(float h) {slantHeight = h;}
float Pyramid::getVolume() {return width*width*(sqrtf(pow(slantHeight,2) - pow(width/2,2)))/3;}
float Pyramid::getSurfaceArea() {return width*width + 2*width*slantHeight;}