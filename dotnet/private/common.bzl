"Utility functions"

def as_iterable(v):
    """Convert give variable to iterable

    Args:
        v: variable to convert

    Returns:
        iterable
    """
    if type(v) == "list":
        return v
    if type(v) == "tuple":
        return v
    if type(v) == "depset":
        return v.to_list()
    fail("as_iterator failed on {}".format(v))
