To run this app, there are two options

### If you do not have cmake installed:
In the main folder, run this command to compile:
  "g++ --std=c++11 ./src/*.cpp -o out.app"
Then run "./out.app" to run the app

### If you have cmake installed:
In main folder, just run "sh build.sh"
It will compile the program into out.app in the build folder, and will automatically run it
If you want to run it without re-compiling, run "sh run.sh"
