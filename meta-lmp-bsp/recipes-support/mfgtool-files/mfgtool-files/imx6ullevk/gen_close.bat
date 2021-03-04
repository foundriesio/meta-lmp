@echo off

:: Copyright (C) 2021 Foundries.IO
::
:: SPDX-License-Identifier: MIT
::

:: this will generate the nxp uuu.exe closing script based on the srktool *fuse.bin file

setlocal enableextensions enabledelayedexpansion
IF ERRORLEVEL 1 ECHO Unable to enable extensions
IF NOT DEFINED FUSEBIN (SET FUSEBIN=cst-3.3.1\crts\SRK_1_2_3_4_fuse.bin)
IF NOT DEFINED CLOSE_DEST (SET CLOSE_DEST=%DIR%close.uuu)

set me=%0
set DIR=%~dp0


:PROCESSINPUT
if "%1"=="" goto validate
if "%1"=="-s" (
	set FUSEBIN=%2
	goto doshift
)
if "%1"=="-d" (
	set CLOSE_DEST=%2
	goto doshift
) else (
	echo ERROR: Invalid Parameter: %1
	goto usage
)

:DOSHIFT
shift
shift
goto processinput

:USAGE
echo Usage: %me% [-s source_file] [-d destination_file]
echo where:
echo    source_file defauilts to cst-3.3.1\crts\SRK_1_2_3_3_fuse.bin
echo    destination_file defaults to %DIR%close.uuu
exit /B

:file_name_from_path <resultVar> <pathVar>
(
    set "%~1=%~dp2"
    exit /B
)

:VALIDATE
if not exist "%FUSEBIN%" (
    echo Source '%FUSEBIN% not found
    goto usage
)
call :file_name_from_path DIR !CLOSE_DEST!
if not exist "%DIR%" (
    md %DIR%
)
if not exist "%DIR%" (
    echo cannot make %DIR% folder
    goto usage
)

certutil -f -encodehex %FUSEBIN% .hex.txt 12 >nul
set _UCase=A B C D E F
for /f "tokens=*" %%a in (.hex.txt) do (
  set line=%%a
)
del .hex.txt
for %%Z in (%_UCase%) do set line=!line:%%Z=%%Z!
(
echo.uuu_version 1.2.39
echo.
echo.SDP: boot -f SPL-mfgtool.signed -dcdaddr 0x0907000 -cleardcd
echo.
echo.SDPV: delay 1000
echo.SDPV: write -f u-boot-mfgtool.itb
echo.SDPV: jump
echo.
echo.FB: ucmd if mmc dev 0; then setenv fiohab_dev 0; else setenv fiohab_dev 1; fi;
echo.
echo.FB: ucmd setenv srk_0 0x!line:~6,2!!line:~4,2!!line:~2,2!!line:~0,2!
echo.FB: ucmd setenv srk_1 0x!line:~14,2!!line:~12,2!!line:~10,2!!line:~8,2!
echo.FB: ucmd setenv srk_2 0x!line:~22,2!!line:~20,2!!line:~18,2!!line:~16,2!
echo.FB: ucmd setenv srk_3 0x!line:~30,2!!line:~28,2!!line:~26,2!!line:~24,2!
echo.FB: ucmd setenv srk_4 0x!line:~38,2!!line:~36,2!!line:~34,2!!line:~32,2!
echo.FB: ucmd setenv srk_5 0x!line:~46,2!!line:~44,2!!line:~42,2!!line:~40,2!
echo.FB: ucmd setenv srk_6 0x!line:~54,2!!line:~52,2!!line:~50,2!!line:~48,2!
echo.FB: ucmd setenv srk_7 0x!line:~62,2!!line:~60,2!!line:~58,2!!line:~56,2!
echo.
echo.FB: ucmd if fiohab_close; then echo Platform Secured; else echo Error, Can Not Secure the Platform; fi
echo.FB: acmd reset
echo.
echo.FB: DONE
) > %CLOSE_DEST%
ENDLOCAL
