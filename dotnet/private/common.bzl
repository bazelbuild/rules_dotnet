def executable_extension(ctx):
    extension = ""
    if ctx.os.name.startswith("windows"):
        extension = ".exe"
    return extension

def bat_extension(ctx):
    extension = ""
    if ctx.os.name.startswith("windows"):
        extension = ".bat"
    return extension

def as_iterable(v):
    if type(v) == "list":
        return v
    if type(v) == "tuple":
        return v
    if type(v) == "depset":
        return v.to_list()
    fail("as_iterator failed on {}".format(v))

def env_execute(ctx, arguments, environment = {}, **kwargs):
    """env_executes a command in a repository context. It prepends "env -i"
    to "arguments" before calling "ctx.execute".

    Variables that aren't explicitly mentioned in "environment"
    are removed from the environment. This should be preferred to "ctx.execut"e
    in most situations.
    """
    if ctx.os.name.startswith("windows"):
        return ctx.execute(arguments, environment = environment, **kwargs)
    env_args = ["env", "-i"]
    environment = dict(environment)
    for var in ["TMP", "TMPDIR"]:
        if var in ctx.os.environ and not var in environment:
            environment[var] = ctx.os.environ[var]
    for k, v in environment.items():
        env_args.append("%s=%s" % (k, v))
    arguments = env_args + arguments
    return ctx.execute(arguments, **kwargs)
