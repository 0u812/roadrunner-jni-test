To build:
```
$CXX -I/path/to/jdk/include proj.cpp TestClass.cpp -Ipath/to/jni_md.h -Ipath/to/roadrunner/include -Ipath/to/rr-third-party-include -Lpath/to/rr/lib -lroadrunner -shared -fPIC -o libproj.so
```
