#include <iostream>
#include "Box.h"
#include "Pyramid.h"
#include "Sphere.h"

using namespace std;

void createBox () {
    cout << "Creating a box" << endl;

    float w,l,h;
    cout << "Width: ";
    cin >> w;
    cout << "Length: ";
    cin >> l;
    cout << "Height: ";
    cin >> h;

    Box b = Box(w,l,h);

    cout << endl;
    cout << "Its volume is " << b.getVolume() << endl;
    cout << "Its surface area is " << b.getSurfaceArea() << endl;
}
void createSphere () {
    cout << "Creating a sphere" << endl;

    float r;
    cout << "Radius: ";
    cin >> r;

    Sphere s = Sphere(r);

    cout << endl;
    cout << "Its volume is " << s.getVolume() << endl;
    cout << "Its surface area is " << s.getSurfaceArea() << endl;
}
void createPyramid () {
    cout << "Creating a pyramid" << endl;

    float w,h;
    cout << "Square Base Width: ";
    cin >> w;
    cout << "Slant Height: ";
    cin >> h;

    Pyramid p = Pyramid(w,h);

    cout << endl;
    cout << "Its volume is " << p.getVolume() << endl;
    cout << "Its surface area is " << p.getSurfaceArea() << endl;
}

int main () {
    cout << "Welcome to Volume Calculator" << endl;
    cout << "Enter one of the following to create the shape" << endl;
    cout << "   b: Box" << endl;
    cout << "   s: Sphere" << endl;
    cout << "   p: Pyramid" << endl;
    cout << "? ";

    char in;
    cin >> in;

    cout << endl;
    switch (in) {
        case 'b':
            createBox();
            break;
        case 's':
            createSphere();
            break;
        case 'p':
            createPyramid();
            break;

        default:
            cout << in << " is not a valid shape" << endl;
    }

    return 0;
}