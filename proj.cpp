#include "proj.hpp"
#include "rr/rrRoadRunner.h"

std::string TestClass::getStr() const {
  //return "I am Groot";
  return rr::RoadRunner::getExtendedVersionInfo();
}
