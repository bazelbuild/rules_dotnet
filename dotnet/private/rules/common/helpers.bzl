"""Helper functions for common functionality"""

LOG_LEVELS = {
    "fatal": 1,
    "error": 2,
    "warn": 3,
    "info": 4,
    "debug": 5,
}

def envs_for_log_level(log_level):
    """Returns a list environment variables to set for a given log level

    Args:
        log_level: The log level string value
    Returns:
        A list of environment variables to set to turn on the launcher logs.
    """
    if log_level not in LOG_LEVELS.keys():
        fail("log_level must be one of {} but got {}".format(LOG_LEVELS.keys(), log_level))
    envs = []
    log_level_numeric = LOG_LEVELS[log_level]
    if log_level_numeric >= LOG_LEVELS["fatal"]:
        envs.append("DOTNET_BINARY__LOG_FATAL")
    if log_level_numeric >= LOG_LEVELS["error"]:
        envs.append("DOTNET_BINARY__LOG_ERROR")
    if log_level_numeric >= LOG_LEVELS["warn"]:
        envs.append("DOTNET_BINARY__LOG_WARN")
    if log_level_numeric >= LOG_LEVELS["info"]:
        envs.append("DOTNET_BINARY__LOG_INFO")
    if log_level_numeric >= LOG_LEVELS["debug"]:
        envs.append("DOTNET_BINARY__LOG_DEBUG")
    return envs
