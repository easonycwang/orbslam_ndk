#include <chrono>

#include <sched.h>
#include <unistd.h>

class Timer {
public:
    Timer() {
        start = std::chrono::high_resolution_clock::now();
    }

    double Tick() {
        end = std::chrono::high_resolution_clock::now();
        auto duration_opt = std::chrono::duration<double, std::milli>(end - start).count();
        //printf("[%s] time cost = %lf ms\n", func_name, duration_opt);
        start = std::chrono::high_resolution_clock::now();
        return duration_opt;
    }

private:
    std::chrono::time_point<std::chrono::high_resolution_clock> start;
    std::chrono::time_point<std::chrono::high_resolution_clock> end;
};

static void BindCpu(uint8_t core_mask, bool need_log) {
    cpu_set_t mask;
    CPU_ZERO(&mask);

    for (uint32_t i = 0; i < 8; i++) {
        if (core_mask & (0x01 << i)) {
            CPU_SET(i, &mask);
        }
    }

    int ret = sched_setaffinity(0, sizeof(mask), &mask);
    if (need_log) {
        printf("[ORBSLAM3] bind_cpu core[%x] ret=%d, mask=%x\n", core_mask, ret, mask);
    }
}