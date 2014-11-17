Building Instructions:

* Set the CXX environment variable to your C++ compiler
* Run `git clone --recursive https://github.com/0u812/roadrunner-jni-test`
* Ensure you have an LLVM installation (preferably 3.5 or 3.4) with llvm-config in your PATH
* Create a file named user-config.sh in the source root directory with the following content:
```
JDK_INCLUDE=/path/to/dir/containing/jni.h
JNI_INCLUDE=/path/to/dir/containing/jni_md.h
```
* Run `./build-rrjni.sh`
