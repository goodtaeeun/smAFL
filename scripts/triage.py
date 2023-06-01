import re
TOP_SIG = " #0 "

def warn(msg, buf):
    # print("[Warning]: %s" % msg)
    # print("Check the following replay log:")
    # print(buf)
    pass


# Obtain the function where the crash had occurred.
def get_crash_func(buf):
    match = re.search(r"#0 0x[0-9a-f]+ in [\S]+", buf)
    if match is None:
        return ""
    start_idx, end_idx = match.span()
    line = buf[start_idx:end_idx]
    return line.split()[-1]

# Get the direct caller of the function that crashed.
def get_crash_func_caller(buf):
    match = re.search(r"#1 0x[0-9a-f]+ in [\S]+", buf)
    if match is None:
        return ""
    start_idx, end_idx = match.span()
    line = buf[start_idx:end_idx]
    return line.split()[-1]


# Helper function for for-all check.
def check_all(buf, checklist):
    for str_to_check in checklist:
        if str_to_check not in buf:
            return False
    return True


# Helper function for if-any check.
def check_any(buf, checklist):
    for str_to_check in checklist:
        if str_to_check in buf:
            return True
    return False


def check_cxxfilt_2016_4487(buf):
    if get_crash_func(buf) == "register_Btype":
        if "cplus-dem.c:4329" in buf:
            return True
        else:
            warn("Unexpected crash point in register_Btype()", buf)
            return False
    else:
        return False


def check_cxxfilt_2016_4489(buf):
    # Checking for "string_appendn" can be loose, since it has many call-sites.
    # Therefore, check for the specific call-site in gnu_special().
    return check_all(buf, ["cplus-dem.c:3016"])


def check_cxxfilt_2016_4490(buf):
    if get_crash_func(buf) == "d_unqualified_name":
        if "cp-demangle.c:1596" in buf or "cp-demangle.c:1597" in buf:
            return True
        elif "cp-demangle.c:1576" in buf:
            # Although crash point is slightly different, has the same root
            # cause (integer overflow in d_source_name).
            return True
        else:
            warn("Unexpected crash point in d_unqualified_name()", buf)
            return False
    else:
        return False


def check_cxxfilt_2016_4492(buf):
    if "stack-overflow" in buf:
        return False
    if get_crash_func(buf) == "do_type":
        if check_any(buf, ["cplus-dem.c:3616", "cplus-dem.c:3791"]):
            # typevec[] accessing points.
            return True
        # If do_type()'s line num is gone, rely on the callsite's line num.
        elif "cplus-dem.c:4241" in buf:
            # do_arg() -> do_type()
            return True
        elif "cplus-dem.c:1548" in buf or "cplus-dem.c:1595" in buf:
            # iterate_demangle_function() -> demangle_signature() -> do_type()
            return True
        else:
            warn("Unexpected crash point in do_type", buf)
            return False
    else:
        return False