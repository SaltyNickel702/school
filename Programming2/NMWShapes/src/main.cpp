#include <iostream>
#include "Box.h"
#include "Pyramid.h"
#include "Sphere.h"
#include "Torus.h"

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

    float w,l,h;
    cout << "Base Width: ";
    cin >> w;
    cout << "Base Length: ";
    cin >> l;
    cout << "Height: ";
    cin >> h;

    Pyramid p = Pyramid(w,l,h);

    cout << endl;
    cout << "Its volume is " << p.getVolume() << endl;
    cout << "Its surface area is " << p.getSurfaceArea() << endl;
}
void createTorus () {
    cout << "Creating a torus" << endl;

    float r1, r2;
    cout << "Radius to inner side: ";
    cin >> r1;
    cout << "Radius to outer side: ";
    cin >> r2;

    Torus t = Torus(r1,r2);

    cout << endl;
    cout << "Its volume is " << t.getVolume() << endl;
    cout << "Its surface area is " << t.getSurfaceArea() << endl;
}

int main () {
    cout << "Welcome to Volume Calculator" << endl;
    
    bool running = true;
    while (running) {
        cout << "Enter one of the following to create the shape" << endl;
        cout << "   b: Box" << endl;
        cout << "   s: Sphere" << endl;
        cout << "   p: Pyramid" << endl;
        cout << "   t: Torus" << endl;
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
            case 't':
                createTorus();
                break;

            default:
                cout << in << " is not a valid shape" << endl;
        }

        cout << endl;
        cout << "Want to make another shape? (Y/N)" << endl;

        char yN;
        cin >> yN;

        if (yN == 'N') {
            running = false;
        } else if (yN != 'Y') {
            cout << yN << " is not recognized as (Y/N)" << endl;
            running = false;
        }
        
    }

    cout << endl;
    return 0;
}