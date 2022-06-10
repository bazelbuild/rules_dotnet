using System;
using System.Threading.Tasks;
using NuGet.Common;

namespace Afas.BazelDotnet.Nuget
{
  internal class ConsoleLogger : LoggerBase
  {
    private readonly LogLevel _logLevel;

    public ConsoleLogger(LogLevel logLevel)
    {
      _logLevel = logLevel;
    }

    public override void Log(ILogMessage message)
    {
      if(message.Level >= _logLevel)
      {
        Console.ForegroundColor = message.Level switch
        {
          LogLevel.Debug => ConsoleColor.DarkBlue,
          LogLevel.Error => ConsoleColor.Red,
          LogLevel.Information => ConsoleColor.White,
          LogLevel.Minimal => ConsoleColor.White,
          LogLevel.Verbose => ConsoleColor.Blue,
          LogLevel.Warning => ConsoleColor.Yellow,
          _ => Console.ForegroundColor
        };
        Console.WriteLine(message.Message);
        Console.ResetColor();
      }
    }

    public override Task LogAsync(ILogMessage message)
    {
      Log(message);
      return Task.CompletedTask;
    }
  }
}