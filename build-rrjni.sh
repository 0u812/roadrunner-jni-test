
which llvm-config

if [ $? -ne 0 ]; then
  echo "llvm-config is not in your PATH"
  exit 1
fi

# The following variables must be set in user-config.sh
# JDK_INCLUDE=jdk-path
# JNI_INCLUDE=jni-path

if [ ! -f ./user-config.sh ]; then
  echo "No user-config.sh found"
  exit 1
fi

# Get config vars
source ./user-config.sh

mkdir -p build/rr-thirdparty && cd build/rr-thirdparty

# Build rr deps
cmake -DCMAKE_INSTALL_PREFIX=../../install/rr-thirdparty ../../roadrunner/third_party && make -j4 install

# make rr build dir
mkdir -p ../roadrunner && cd ../roadrunner

# Build roadrunner
cmake -DCMAKE_INSTALL_PREFIX=../../install/roadrunner -DTHIRD_PARTY_INSTALL_FOLDER=../../install/rr-thirdparty -DCMAKE_BUILD_TYPE=Release -DBUILD_PYTHON=OFF -DBUILD_TESTS=OFF -DBUILD_TEST_TOOLS=OFF ../../roadrunner && make -j4 install

# return to root path
cd ../..

RR_INSTALL_ROOT=install/roadrunner
RR_INCLUDE=$RR_INSTALL_ROOT/include
RR_TP_INCLUDE=install/rr-thirdparty/include
RR_LIB_PATH=$RR_INSTALL_ROOT/lib

$CXX -I$JDK_INCLUDE proj.cpp TestClass.cpp -I$JNI_INCLUDE -I$RR_INCLUDE -I$RR_TP_INCLUDE -L$RR_LIB_PATH -lroadrunner -shared -fPIC -o libproj.so

# Export the required library paths
export LD_LIBRARY_PATH=/vagrant:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/vagrant/install/roadrunner/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/vagrant/install/rr-thirdparty/lib:$LD_LIBRARY_PATH

# Compile Java code
javac test/myproj/test.jav

# Run Java code
java test.myproj.testa
