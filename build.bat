@echo off
REM Fixbot Windows Executable Builder
REM This script uses PyInstaller to bundle sysdoc/main.py with all dependencies

setlocal enabledelayedexpansion

REM Activate virtual environment
call .venv\Scripts\activate.bat

echo [*] Ensuring PyInstaller is installed...
python -m pip install pyinstaller --quiet

echo [*] Building Fixbot.exe...
echo.

REM Main PyInstaller command with all required flags
python -m PyInstaller ^
  --name=Fixbot ^
  --onefile ^
  --console ^
  --add-data="sysdoc\.env;sysdoc" ^
  --add-data="sysdoc\core;sysdoc\core" ^
  --add-data="sysdoc\display;sysdoc\display" ^
  --add-data="sysdoc\games;sysdoc\games" ^
  --add-data="sysdoc\gitpilot;sysdoc\gitpilot" ^
  --add-data="sysdoc\modules;sysdoc\modules" ^
  --add-data="sysdoc\tickets;sysdoc\tickets" ^
  --hidden-import=google.generativeai ^
  --hidden-import=prompt_toolkit ^
  --hidden-import=rich ^
  --hidden-import=psutil ^
  --hidden-import=wmi ^
  --hidden-import=winshell ^
  --hidden-import=sysdoc.core.conversation_memory ^
  --hidden-import=sysdoc.core.executor ^
  --hidden-import=sysdoc.core.gemini_client ^
  --hidden-import=sysdoc.core.intent_engine ^
  --hidden-import=sysdoc.core.permission_gate ^
  --hidden-import=sysdoc.core.prompt_builder ^
  --hidden-import=sysdoc.core.report_generator ^
  --hidden-import=sysdoc.core.verifier ^
  --hidden-import=sysdoc.display.animations ^
  --hidden-import=sysdoc.display.banner ^
  --hidden-import=sysdoc.display.formatter ^
  --hidden-import=sysdoc.games.ticket_rush ^
  --hidden-import=sysdoc.gitpilot.ai_helper ^
  --hidden-import=sysdoc.gitpilot.config ^
  --hidden-import=sysdoc.gitpilot.git_ops ^
  --hidden-import=sysdoc.gitpilot.main ^
  --hidden-import=sysdoc.modules.dev_env ^
  --hidden-import=sysdoc.modules.file_finder ^
  --hidden-import=sysdoc.modules.installer ^
  --hidden-import=sysdoc.modules.network ^
  --hidden-import=sysdoc.modules.storage ^
  --hidden-import=sysdoc.modules.system_health ^
  --hidden-import=sysdoc.modules.updater ^
  --hidden-import=sysdoc.tickets.ticket_manager ^
  --distpath=dist ^
  --workpath=build ^
  --specpath=. ^
  sysdoc\main.py

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [?] Build complete!
    echo [?] Output: dist\Fixbot.exe
    echo.
    echo Next step: Compile installer.iss with Inno Setup
) else (
    echo.
    echo [?] Build failed!
    echo [?] Check output above for errors.
    exit /b 1
)

endlocal
