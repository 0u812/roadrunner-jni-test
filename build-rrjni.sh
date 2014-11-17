
JDK_INCLUDE=jdk
JNI_INCLUDE=jni
RR_INSTALL_ROOT=rr
RR_INCLUDE=$RR_INSTALL_ROOT/include
RR_LIB_PATH=$RR_INSTALL_ROOT/lib

mkdir -p build/rr-thirdparty && cd build/rr-thirdparty

cmake -DCMAKE_INSTALL_PREFIX=../../install/rr-thirdparty ../../roadrunner/third_party && make -j4 install

$CXX -I$JDK_INCLUDE proj.cpp TestClass.cpp -I$JNI_INCLUDE -I$RR_INCLUDE -I$RR_TP_INCLUDE -L$RR_LIB_PATH -lroadrunner -shared -fPIC -o libproj.so
