package test.myproj;

public class TestClass {
  public native String getStr();
  public TestClass() { initialize(); }

  private native void initialize();
  private long nativeHandle;

  static {
    System.loadLibrary("proj");
  }
}