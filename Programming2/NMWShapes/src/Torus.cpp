#include "Torus.h"
#include <cmath>
#define PI 3.14159

Torus::Torus() {
    r1 = 0;
    r2 = 0;
}
Torus::Torus(float r1, float r2) {
    this->r1 = r1;
    this->r2 = r2;
}
void Torus::setRadius1(float r) {
    r1 = r;
}
void Torus::setRadius2(float r) {
    r2 = r;
}
float Torus::getVolume() {
    float r = (r2-r1)/2; //minor radius
    float R = r1 + r; //major radius
    return (PI*pow(r,2))*(2*PI*R);
}
float Torus::getSurfaceArea() {
    float r = (r2-r1)/2; //minor radius
    float R = r1 + r; //major radius
    return (2*PI*R)*(2*PI*r);
}