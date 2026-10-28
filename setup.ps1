<#
.SYNOPSIS
    COS HUB setup script for Windows PowerShell.
#>

Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "  COS HUB - Windows PowerShell Setup & Verification" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    if (Test-Path "C:\tools\flutter\bin\flutter.bat") {
        Write-Host "[INFO] Detected Flutter in C:\tools\flutter\bin. Adding to session PATH..." -ForegroundColor Yellow
        $env:PATH = "C:\tools\flutter\bin;" + $env:PATH
    } else {
        Write-Host "[ERROR] 'flutter' command could not be located in PATH." -ForegroundColor Red
        Write-Host "Please install Flutter SDK: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "[1/3] Verifying Flutter installation..." -ForegroundColor Green
flutter --version

Write-Host ""
Write-Host "[2/3] Resolving dependencies (flutter pub get)..." -ForegroundColor Green
flutter pub get

Write-Host ""
Write-Host "[3/3] Ready to launch COS HUB!" -ForegroundColor Green
Write-Host ""
Write-Host "Available launch commands:" -ForegroundColor Cyan
Write-Host "  1. Chrome Web:      flutter run -d chrome --web-port=4200" -ForegroundColor White
Write-Host "  2. Windows Desktop: flutter run -d windows" -ForegroundColor White
Write-Host "  3. Ngrok Share:     ngrok http 4200 --url renewed-oriole-exotic.ngrok-free.app" -ForegroundColor White
Write-Host ""
