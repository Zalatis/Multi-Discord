@echo off
setlocal EnableDelayedExpansion

set "DiscordBase=%localappdata%\Discord"
set "ProfileName=Multi-Discord"
set "ProfilesPath=%DiscordBase%\profiles"
set "ProfilePath=%ProfilesPath%\%ProfileName%"

set "LatestVersion="
for /d %%D in ("%DiscordBase%\app-*") do (
    set "Version=%%~nxD"
    set "Version=!Version:app-=!"
    if "!Version!" gtr "!LatestVersion!" (
        set "LatestVersion=!Version!"
    )
)

if not defined LatestVersion (
    echo Discord non trouve.
    exit /b
)

set "DiscordExe=%DiscordBase%\app-!LatestVersion!\Discord.exe"
if not exist "!DiscordExe!" (
    echo Discord.exe introuvable.
    exit /b
)

if not exist "%ProfilesPath%" mkdir "%ProfilesPath%"

set "cleaning=false"

powershell -NoProfile -Command ^
  "$profileName = '%ProfileName%'; Get-WmiObject Win32_Process | Where-Object { $_.Name -eq 'Discord.exe' -and $_.CommandLine -match $profileName } | ForEach-Object { $_.ProcessId }" > "%temp%\%ProfileName%_alt_pids.txt"

if exist "%temp%\%ProfileName%_alt_pids.txt" (
    for /f %%p in (%temp%\%ProfileName%_alt_pids.txt) do (
        set "cleaning=true"
        taskkill /pid %%p /f >nul 2>&1
    )
)
del "%temp%\%ProfileName%_alt_pids.txt"

if exist "%ProfilePath%" rmdir /s /q "%ProfilePath%"
mkdir "%ProfilePath%"

if /i "%cleaning%"=="false" (
    set "DISCORD_USER_DATA_DIR=%ProfilePath%"
    start "" "!DiscordExe!" --multi-instance --disable-system-tray
) else (
    echo Discord processes were killed, skipping launch.
)

endlocal
exit /b
