ANDROID_NDK_ROOT="D:/code/android-ndk-r23c"
echo $ANDROID_NDK_ROOT

echo "Configuring and building Thirdparty/DBoW2 ..."
cd Thirdparty/DBoW2
rm -rf build
mkdir build
cd build
cmake -G "MinGW Makefiles" -DCMAKE_SYSTEM_NAME=Android \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_static \
    -DANDROID_TOOLCHAIN=clang \
    -DCMAKE_BUILD_TYPE=Release \
    -DANDROID_ABI=arm64-v8a \
    -DBUILD_SHARED_LIBS=ON \
    -DANDROID_NATIVE_API_LEVEL=android-24 $@ ..
cmake --build . -j8


echo "Configuring and building Thirdparty/g2o ..."
cd ../../g2o
rm -rf build
mkdir build
cd build
cmake -G "MinGW Makefiles" -DCMAKE_SYSTEM_NAME=Android \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_static \
    -DANDROID_TOOLCHAIN=clang \
    -DCMAKE_BUILD_TYPE=Release \
    -DANDROID_ABI=arm64-v8a \
    -DBUILD_SHARED_LIBS=ON \
    -DANDROID_NATIVE_API_LEVEL=android-24 $@ ..
cmake --build .


echo "Configuring and building ORB_SLAM3 ..."
cd ../../../
rm -rf build
mkdir build
cd build
cmake -G "MinGW Makefiles" -DCMAKE_SYSTEM_NAME=Android \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_static \
    -DANDROID_TOOLCHAIN=clang \
    -DCMAKE_BUILD_TYPE=Release \
    -DANDROID_ABI=arm64-v8a \
    -DBUILD_SHARED_LIBS=ON \
    -DANDROID_NATIVE_API_LEVEL=android-24 $@ ..
cmake --build . -j8

echo "Uncompress vocabulary ..."
cd ../
cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
