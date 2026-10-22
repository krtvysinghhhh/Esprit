@echo off
setlocal

echo.
echo   ===========================================================
echo     Esprit Windows Command Prompt (CMD) Installer
echo   ===========================================================
echo.

where powershell >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: PowerShell is required to run the automated installer.
    echo Please install Esprit via Cargo: cargo install --git https://github.com/krtvysinghhhh/Esprit.git esprit-cli
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression (Invoke-RestMethod 'https://raw.githubusercontent.com/krtvysinghhhh/Esprit/main/scripts/install.ps1')"

if %errorlevel% equ 0 (
    echo.
    echo Installation complete. Please restart your CMD window to refresh PATH.
)
endlocal
