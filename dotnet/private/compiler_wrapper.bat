@echo on
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

::
: This wrapper script is used because the C#/F# compilers both embed absolute paths
: into their outputs and those paths are not deterministic. The compilers also
: allow overriding these paths using pathmaps. Since the paths can not be known
: at analysis time we need to override them at execution time.
::

set DOTNET_EXECUTABLE=%2
set COMPILER=%2
for /F "delims=" %%i in (%COMPILER%) do set COMPILER_BASENAME="%%~ni"

set PATHMAP_FLAG="-pathmap"

:: Needed because unfortunately the F# compiler uses a different flag name
if "%COMPILER_BASENAME%" == "fsc.dll" set PATHMAP_FLAG="--pathmap"

set PATHMAP="%PATHMAP_FLAG%:%cd%=."

set args=%*
rem Escape \ and * in args before passsing it with double quote
if defined args (
  set args=!args:\=\\\\!
  set args=!args:"=\"!
)

"!DOTNET_EXECUTABLE!" !args!
