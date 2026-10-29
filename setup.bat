@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo   COS HUB - Windows Setup ^& Dependency Installer
echo ===================================================
echo.

where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    if exist "C:\tools\flutter\bin\flutter.bat" (
        echo [INFO] Found Flutter at C:\tools\flutter\bin. Adding to current session PATH...
        set "PATH=C:\tools\flutter\bin;%PATH%"
    ) else (
        echo [ERROR] Flutter SDK was not found in PATH or at C:\tools\flutter\bin.
        echo Please install Flutter or add your Flutter bin directory to PATH.
        echo Official guide: https://docs.flutter.dev/get-started/install/windows
        pause
        exit /b 1
    )
)

echo [1/3] Checking Flutter environment...
call flutter --version
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Flutter check failed.
    pause
    exit /b 1
)

echo.
echo [2/3] Fetching project dependencies (flutter pub get)...
call flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to download Flutter packages.
    pause
    exit /b 1
)

echo.
echo [3/3] Setup complete!
echo.
echo ===================================================
echo   How to run COS HUB:
echo ===================================================
echo   - Clean Web Server without Debug Service (Recommended):
echo       flutter run -d web-server --release --web-port=4200
echo.
echo   - Direct Chrome Web:
echo       flutter run -d chrome --web-port=4200
echo.
echo   - Native Windows Desktop App:
echo       flutter run -d windows
echo.
echo   - Share via ngrok tunnel:
echo       ngrok http 4200 --url renewed-oriole-exotic.ngrok-free.app
echo ===================================================
echo.

pause
