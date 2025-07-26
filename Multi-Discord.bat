@echo off
setlocal EnableDelayedExpansion

set "DiscordBase=%localappdata%\Discord"
set "ProfileName=Multi-Discord"
set "ProfilesPath=%DiscordBase%\profiles"
set "ProfilePath=%ProfilesPath%\%ProfileName%"

REM Find latest installed Discord version
set "LatestVersion="
for /d %%D in ("%DiscordBase%\app-*") do (
    set "Version=%%~nxD"
    set "Version=!Version:app-=!"
    if "!Version!" gtr "!LatestVersion!" (
        set "LatestVersion=!Version!"
    )
)

if not defined LatestVersion exit /b
set "DiscordExe=%DiscordBase%\app-!LatestVersion!\Discord.exe"
if not exist "!DiscordExe!" exit /b

REM Ensure profiles directory exists
if not exist "%ProfilesPath%" mkdir "%ProfilesPath%"

REM --- Kill any Discord process using this Alt profile ---
set "cleaning=false"
powershell -Command ^
  "Get-WmiObject Win32_Process | Where-Object { $_.Name -eq 'Discord.exe' -and $_.CommandLine -match '%ProfileName%' } | ForEach-Object { $_.ProcessId }" > "%temp%\alt_pids.txt"

setlocal EnableDelayedExpansion
set "pids_exist=false"

REM Check if file is not empty before proceeding
for %%A in ("%temp%\alt_pids.txt") do if %%~zA gtr 0 (
  for /f %%p in (%temp%\alt_pids.txt) do (
    set "pids_exist=true"
    taskkill /pid %%p /f >nul 2>&1
  )
)
endlocal & set "cleaning=%pids_exist%"

echo %cleaning%
del "%temp%\%ProfileName%_alt_pids.txt"
REM --- End kill block ---

REM Remove and recreate the profile folder
if exist "%ProfilePath%" rmdir /s /q "%ProfilePath%"
mkdir "%ProfilePath%"

REM Launch Discord with the selected profile only if not cleaning
if /i "%cleaning%"=="false" (
  set "DISCORD_USER_DATA_DIR=%ProfilePath%"
  start "" "!DiscordExe!" --multi-instance --disable-system-tray
) else (
  echo Discord processes were killed, skipping launch.
)
endlocal
exit /b
