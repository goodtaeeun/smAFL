from triage import *

# (target bin, target cmdline, input src, additional option, triage function)
# fuzz targets each for atoi, strcmp, strstr
FUZZ_TARGETS = [
    ("cxxfilt-2016-4487-atoi", "", "stdin", check_cxxfilt_2016_4487),
    ("cxxfilt-2016-4489-atoi", "", "stdin", check_cxxfilt_2016_4489),
    ("cxxfilt-2016-4490-atoi", "", "stdin", check_cxxfilt_2016_4490),
    ("cxxfilt-2016-4492-atoi", "", "stdin", check_cxxfilt_2016_4492),
    ("cxxfilt-2016-4487-strcmp", "", "stdin", check_cxxfilt_2016_4487),
    ("cxxfilt-2016-4489-strcmp", "", "stdin", check_cxxfilt_2016_4489),
    ("cxxfilt-2016-4490-strcmp", "", "stdin", check_cxxfilt_2016_4490),
    ("cxxfilt-2016-4492-strcmp", "", "stdin", check_cxxfilt_2016_4492),
    ("cxxfilt-2016-4487-strstr", "", "stdin", check_cxxfilt_2016_4487),
    ("cxxfilt-2016-4489-strstr", "", "stdin", check_cxxfilt_2016_4489),
    ("cxxfilt-2016-4490-strstr", "", "stdin", check_cxxfilt_2016_4490),
    ("cxxfilt-2016-4492-strstr", "", "stdin", check_cxxfilt_2016_4492),    
]


def generate_fuzzing_worklist( iteration):
    worklist = []

    for (targ_prog, cmdline, src, _) in FUZZ_TARGETS:
        if src not in ["stdin", "file"]:
            print("Invalid input source specified: %s" % src)
            exit(1)
        for i in range(iteration):
            iter_id = "iter-%d" % i
            worklist.append((targ_prog, cmdline, src, iter_id))

    return worklist


def check_targeted_crash(targ, replay_buf):
    for (targ_prog, _, _, crash_checker) in FUZZ_TARGETS:
        if targ_prog == targ:
            return crash_checker(replay_buf)
    print("Unknown target: %s" % targ)
    exit(1)
