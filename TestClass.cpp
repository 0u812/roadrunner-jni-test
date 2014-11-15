#include "proj.hpp"
#include "test_myproj_TestClass.h"
#include "handle.h"

jstring Java_test_myproj_TestClass_getStr(JNIEnv *env, jobject obj) {
  TestClass* x = getHandle<TestClass>(env, obj);
  return env->NewStringUTF(x->getStr().c_str());
}

void Java_test_myproj_TestClass_initialize(JNIEnv *env, jobject obj) {
  TestClass* x = new TestClass();
  setHandle(env, obj, x);
}