
# The following variables must be set in user-config.sh
# JDK_INCLUDE=jdk
# JNI_INCLUDE=jni

if [ ! -f ./user-config.sh ]; then
  echo "No user-config.sh found"
  exit 1
fi

source ./user-config.sh

mkdir -p build/rr-thirdparty && cd build/rr-thirdparty

cmake -DCMAKE_INSTALL_PREFIX=../../install/rr-thirdparty ../../roadrunner/third_party && make -j4 install

# make rr build dir
mkdir -p ../roadrunner && cd ../roadrunner

cmake -DCMAKE_INSTALL_PREFIX=../../install/roadrunner -DTHIRD_PARTY_INSTALL_FOLDER=../../install/rr-thirdparty -DCMAKE_BUILD_TYPE=Release -DBUILD_PYTHON=OFF -DBUILD_TESTS=OFF -DBUILD_TEST_TOOLS=OFF ../../roadrunner && make -j4 install

# return to root path
cd ../..

RR_INSTALL_ROOT=install/roadrunner
RR_INCLUDE=$RR_INSTALL_ROOT/include
RR_TP_INCLUDE=install/rr-thirdparty/include
RR_LIB_PATH=$RR_INSTALL_ROOT/lib

$CXX -I$JDK_INCLUDE proj.cpp TestClass.cpp -I$JNI_INCLUDE -I$RR_INCLUDE -I$RR_TP_INCLUDE -L$RR_LIB_PATH -lroadrunner -shared -fPIC -o libproj.so
