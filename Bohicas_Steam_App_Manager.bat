@echo off
title Bohica's Steam App Manager
color 0A

echo ============================================================
echo            Bohica's Steam App Manager
echo      Copyright (c) 2025. All rights reserved.
echo ============================================================
timeout /t 3 >nul
echo.

:: Set default install path
set "STEAMCMD_DIR=%~dp0SteamCMD"
if not exist "%STEAMCMD_DIR%" (
	echo SteamCMD directory not found.
	timeout /t 3 >nul
	echo Creating SteamCMD directory...
	timeout /t 3 >nul
	mkdir "%STEAMCMD_DIR%"
) else (
	echo SteamCMD directory found at "%STEAMCMD_DIR%"
)

:: Check if SteamCMD exists
if not exist "%STEAMCMD_DIR%\steamcmd.exe" (
    echo SteamCMD.exe not found. Downloading from Valve servers...
	timeout /t 3 >nul
    powershell -Command "Invoke-WebRequest -Uri https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -OutFile '%STEAMCMD_DIR%\steamcmd.zip'"
    echo Unzipping steamcmd.zip ...
	timeout /t 3 >nul
    powershell -Command "Expand-Archive '%STEAMCMD_DIR%\steamcmd.zip' -DestinationPath '%STEAMCMD_DIR%' -Force"
    del "%STEAMCMD_DIR%\steamcmd.zip"
    timeout /t 3 >nul
    echo SteamCMD.exe installed successfully.
) else (
    timeout /t 3 >nul
    echo SteamCMD.exe already installed in "%STEAMCMD_DIR%".
)
echo.

:: Ask for app ID
timeout /t 3 >nul
echo You need to enter the Steam App ID.
echo For exmaple, 258550 is for the RUST Dedicated Server.
echo (You can find App IDs at https://steamdb.info/)
timeout /t 3 >nul
set /p APPID="Enter App ID: "

:: Set default install directory (no custom input)
set "INSTALL_DIR=%~dp0server_%APPID%"

if exist "%INSTALL_DIR%" (
    echo.
    echo Existing installation detected!
    timeout /t 3 >nul
    echo Steam App ID %APPID% in "%INSTALL_DIR%"
    timeout /t 3 >nul
    echo.
    echo ============================================================
    echo Attempting to update the app with the latest version...
    echo ============================================================
    echo.
) else (
    echo.
    echo No existing installation found for App ID %APPID%.
    timeout /t 3 >nul
    echo.
    echo ============================================================
    echo Creating directory and installing the app...
    echo ============================================================
    echo.
    mkdir "%INSTALL_DIR%"
)

timeout /t 3 >nul
cd /d "%STEAMCMD_DIR%"
steamcmd +force_install_dir "%INSTALL_DIR%" +login anonymous +app_update %APPID% validate +quit

echo.
echo ============================================================
echo  Download/Update complete!
echo  Steam App files are in: %INSTALL_DIR%
echo ============================================================
echo.
timeout /t 3 >nul
echo Done! Press any key to exit...
pause >nul
exit