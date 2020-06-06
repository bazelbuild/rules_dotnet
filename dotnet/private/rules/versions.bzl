def parse_version(version):
    """Convert version to a tuple.
    
       Tuple will have a form (num1, num2, num3, num4, suffix). 
       For example:
          - 1.1 => (1, 1, 0, 0, "")
          - 2.3.4.5 => (2, 3, 4, 5, "")
          - 1.0.1-open => (1, 0, 1, 0, "open")
          - 1.0.1-beta.12 => (1, 0, 1, 12, "beta")
    """

    lversion = version.split(".")
    l = len(lversion)
    if l > 4 or l == 0:
        fail("Invalid version:", version)

    suffix = ""
    for i in range(l):
        if not lversion[i].isdigit():
            if suffix != "":
                fail("Version suffix already defined:", version)
            s = lversion[i].split("-")
            if len(s) != 2:
                fail("Invalid version segment:", version)
            if not s[0].isdigit():
                fail("Not a digit in a version:", version)
            lversion[i] = int(s[0])
            suffix = s[1]
        else:
            lversion[i] = int(lversion[i])

    if l == 4:
        return (lversion[0], lversion[1], lversion[2], lversion[3], suffix)
    elif l == 3:
        return (lversion[0], lversion[1], lversion[2], 0, suffix)
    elif l == 2:
        return (lversion[0], lversion[1], 0, 0, suffix)
    elif l == 1:
        return (lversion[0], 0, 0, 0, suffix)
    else:
        fail("Unreachable")

def test_parse_version():
    a = parse_version("1.1")
    if a != (1, 1, 0, 0, ""):
        print("Unexpected result:", a)
        fail("test 1 failed")

    a = parse_version("2.3.4.5")
    if a != (2, 3, 4, 5, ""):
        print("Unexpected result:", a)
        fail("test 2 failed")

    a = parse_version("1.0.1-open")
    if a != (1, 0, 1, 0, "open"):
        print("Unexpected result:", a)
        fail("test 3 failed")

    a = parse_version("1.0.1-beta.12")
    if a != (1, 0, 1, 12, "beta"):
        print("Unexpected result:", a)
        fail("test 4 failed")

def version2string(tversion):
    """ Converts version tuple to string """
    s = ""
    if tversion[3] != 0:
        s = "{}.{}.{}.{}".format(tversion[0], tversion[1], tversion[2], tversion[3])
    elif tversion[2] != 0:
        s = "{}.{}.{}".format(tversion[0], tversion[1], tversion[2])
    else:
        s = "{}.{}".format(tversion[0], tversion[1])

    if tversion[4] != "":
        s = s + "-" + tversion[4]

    return s

def test_version2string():
    a = "1.1"
    b = parse_version(a)
    c = version2string(b)
    if c != a:
        print("Unexpected result:", c)
        fail("test 1 failed")

    a = "2.3.4.5"
    b = parse_version(a)
    c = version2string(b)
    if c != a:
        print("Unexpected result:", c)
        fail("test 1 failed")

    a = "1.0.1-open"
    b = parse_version(a)
    c = version2string(b)
    if c != a:
        print("Unexpected result:", c)
        fail("test 1 failed")

    a = "1.0.1-beta.12"
    b = parse_version(a)
    c = version2string(b)
    if c != "1.0.1.12-beta":
        print("Unexpected result:", c)
        fail("test 1 failed")

    a = "1.0"
    b = parse_version(a)
    c = version2string(b)
    if c != a:
        print("Unexpected result:", c)
        fail("test 1 failed")

    a = "1.2.3"
    b = parse_version(a)
    c = version2string(b)
    if c != a:
        print("Unexpected result:", c)
        fail("test 1 failed")
