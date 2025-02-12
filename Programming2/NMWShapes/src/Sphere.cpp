#include "Sphere.h"
#include <cmath>
#define PI 3.14159

Sphere::Sphere () {
    this->r = 0;
}
Sphere::Sphere (float radius) {r = radius;}
void Sphere::setRadius(float radius) {r = radius;}
float Sphere::getVolume() {return 4/3*PI*pow(r,3);}
float Sphere::getSurfaceArea() {return 4*PI*pow(r,2);}