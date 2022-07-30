adb shell "mkdir /data/local/tmp/orbslam"
::push libs
adb push ./Thirdparty/DBoW2/lib/libDBoW2.so /data/local/tmp/orbslam
adb push ./Thirdparty/g2o/lib/libg2o.so /data/local/tmp/orbslam
adb push ./Thirdparty/opencv4_4/libs/arm64-v8a/libopencv_java4.so /data/local/tmp/orbslam
adb push ./Thirdparty/libc++_shared.so /data/local/tmp/orbslam
adb push ./lib/libORB_SLAM3.so /data/local/tmp/orbslam
::push resource
adb push ./Vocabulary/ORBvoc.txt /data/local/tmp/orbslam
adb push ./Examples/Stereo-Inertial/EuRoC.yaml /data/local/tmp/orbslam
adb push ./Examples/Stereo-Inertial/stereo_inertial_euroc /data/local/tmp/orbslam
adb push ./Examples/Stereo-Inertial/EuRoC_TimeStamps/V203.txt /data/local/tmp/orbslam/V203_ts.txt
::execute
adb shell "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/local/tmp/orbslam; cd /data/local/tmp/orbslam; chmod 777 stereo_inertial_euroc; ./stereo_inertial_euroc ./ORBvoc.txt ./EuRoC.yaml ./EuRoc_V203 ./V203_ts.txt"

pause
