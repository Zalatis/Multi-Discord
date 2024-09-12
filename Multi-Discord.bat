@echo off
setlocal enabledelayedexpansion

set "DiscordPath=%localappdata%\Discord"
set "LatestVersion="

for /d %%d in ("%DiscordPath%\app-*") do (
    set "Version=%%~nxd"
    set "Version=!Version:app-=!"
    if "!Version!" gtr "!LatestVersion!" (
        set "LatestVersion=!Version!"
    )
)

if defined LatestVersion (
    set "DiscordExe=%DiscordPath%\app-!LatestVersion!\Discord.exe"
    if exist "!DiscordExe!" (
        start "" "!DiscordExe!" --multi-instance
    ) else (
        echo Discord executable not found‚ for !LatestVersion! version
        pause
    )
) else (
    echo Discord is not installed in %localappdata%\Discord
    pause
)

endlocal
