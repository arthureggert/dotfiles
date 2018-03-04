@echo off
setlocal disabledelayedexpansion

set "folder=%~1"
  if not defined folder set "folder=%cd%"

    for /d %%a in ("%folder%\*") do (
        set "size=0"
        for /f "tokens=3,5" %%b in ('dir /-c /a /w /s "%%~fa\*" 2^>nul ^| findstr /b /c:"  "') do if "%%~c"=="" set "size=%%~b"
        setlocal enabledelayedexpansion
        call :GetUnit !size! unit
        call :ConvertBytes !size! !unit! newsize
        echo(%%~nxa - !newsize! !unit!
        endlocal
    )

endlocal
exit /b

:ConvertBytes bytes unit ret
setlocal
if "%~2" EQU "KB" set val=/1024
if "%~2" EQU "MB" set val=/1024/1024
if "%~2" EQU "GB" set val=/1024/1024/1024
if "%~2" EQU "TB" set val=/1024/1024/1024/1024
> %temp%\tmp.vbs echo wsh.echo FormatNumber(eval(%~1%val%),1)
for /f "delims=" %%a in ( 
  'cscript //nologo %temp%\tmp.vbs' 
) do endlocal & set %~3=%%a
del %temp%\tmp.vbs
exit /b


:GetUnit bytes return
set byt=00000000000%1X
set TB=000000000001099511627776X
if %1 LEQ 1024 set "unit=Bytes"
if %1 GTR 1024   set "unit=KB"
if %1 GTR 1048576  set "unit=MB"
if %1 GTR 1073741824  set "unit=GB"
if %byt:~-14% GTR %TB:~-14% set "unit=TB"
endlocal & set %~2=%unit%
exit /b