@echo off
REM Fixbot Installer Builder
REM Requires Inno Setup to be installed: https://jrsoftware.org/isdl.php

REM Try common ISCC installation paths
set "ISCC_PATHS=C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "C:\Program Files\Inno Setup 6\ISCC.exe" "C:\Program Files (x86)\Inno Setup 5\ISCC.exe" "C:\Program Files\Inno Setup 5\ISCC.exe"

set "FOUND=0"
for %%I in (%ISCC_PATHS%) do (
    if exist "%%I" (
        set "ISCC=%%I"
        set "FOUND=1"
        goto :found
    )
)

:found
if %FOUND% EQU 0 (
    echo [!] Inno Setup Compiler not found!
    echo [!] Please install Inno Setup from: https://jrsoftware.org/isdl.php
    echo.
    echo Or manually run:
    echo   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer.iss
    echo   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" installer_x86.iss
    exit /b 1
)

setlocal enabledelayedexpansion

echo [*] Found ISCC at: %ISCC%
echo.

if /I "%~1"=="x86" (
    echo [*] Compiling 32-bit installer...
    "%ISCC%" installer_x86.iss
    if %ERRORLEVEL% EQU 0 (
        echo [?] x86 installer compiled: installer_output\FixbotAI_x86_Setup.exe
    ) else (
        echo [!] x86 installer compilation failed!
        exit /b 1
    )
) else (
    echo [*] Compiling 64-bit installer...
    "%ISCC%" installer.iss
    if %ERRORLEVEL% EQU 0 (
        echo [?] x64 installer compiled: installer_output\FixbotAI_Setup.exe
    ) else (
        echo [!] x64 installer compilation failed!
        exit /b 1
    )
)

echo.
echo [?] Installer compilation complete!

endlocal
