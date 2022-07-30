cmake_minimum_required(VERSION 3.8)
project(DBoW2)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O3 -mfpu=neon")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -O3 -std=c++14 -DANDROID_TOOLCHAIN=clang")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffast-math")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv8-a -mfpu=neon -mfloat-abi=softfp -marm") #neon
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DARM_NEON -ftree-vectorize -DANDROID_ARM_NEON=ON") #neon
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEIGEN_DONT_PARALLELIZE") #eigen

set(HDRS_DBOW2
  DBoW2/BowVector.h
  DBoW2/FORB.h 
  DBoW2/FClass.h       
  DBoW2/FeatureVector.h
  DBoW2/ScoringObject.h   
  DBoW2/TemplatedVocabulary.h)
set(SRCS_DBOW2
  DBoW2/BowVector.cpp
  DBoW2/FORB.cpp      
  DBoW2/FeatureVector.cpp
  DBoW2/ScoringObject.cpp)

set(HDRS_DUTILS
  DUtils/Random.h
  DUtils/Timestamp.h)
set(SRCS_DUTILS
  DUtils/Random.cpp
  DUtils/Timestamp.cpp)


#find_package(OpenCV 4 QUIET)
#if(NOT OpenCV_FOUND)
#   find_package(OpenCV 3.0 QUIET)
#   if(NOT OpenCV_FOUND)
#      message(FATAL_ERROR "OpenCV > 3.0 not found.")
#   endif()
#endif()
set(OpenCV_INCLUDE_DIRS ${PROJECT_SOURCE_DIR}/../opencv4_4/include)
set(OpenCV_LIBS ${PROJECT_SOURCE_DIR}/../opencv4_4/libs/arm64-v8a/libopencv_java4.so)
include_directories(D:/code/boost_1_72_0_for_ndk_r21b/include)

set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

include_directories(${OpenCV_INCLUDE_DIRS})
add_library(DBoW2 SHARED ${SRCS_DBOW2} ${SRCS_DUTILS})
target_link_libraries(DBoW2 ${OpenCV_LIBS})

