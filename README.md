# Multi-Discord

This batch script allows you to launch the latest installed version of Discord with a custom profile and the `--multi-instance` flag. This enables running multiple instances of Discord on your system, each with its own separate user data directory.

## How It Works

1. The script searches the `%localappdata%\Discord` directory for all installed Discord versions.
2. It identifies the latest version of Discord by checking the version numbers in the folder names.
3. It ensures the profiles directory (`%localappdata%\Discord\profiles`) exists and creates a folder for the specified profile (`ProfileName`).
4. Before launching, the script checks for any running Discord processes using that profile and kills them to prevent conflicts.
5. The profile folder is cleared and recreated to ensure a fresh environment.
6. Discord is then launched with the `--multi-instance` and `--disable-system-tray` flags, using the custom profile folder as the `DISCORD_USER_DATA_DIR`.

## Usage

1. Download or copy the batch script.
2. Save the file with a `.bat` extension (e.g., `launch_discord_multi_instance.bat`).
3. Modify the `ProfileName` variable in the script if you want to use a different profile.
4. Double-click the `.bat` file to run it.

The script will automatically detect the latest installed version of Discord, manage the profile folder, and launch Discord with the multi-instance flag.

## Error Handling

- If Discord is not installed in `%localappdata%\Discord`, the script will notify you that Discord is not found.
- If the executable file for the latest version of Discord is missing, you will receive a message indicating the executable was not found.
- If there are existing Discord processes using the specified profile, they will be killed before launching a new instance.

## Notes

- Ensure that Discord is installed in the default `%localappdata%\Discord` directory.
- The script is designed for Windows operating systems.
- Each profile folder acts as an isolated environment for Discord, allowing multiple accounts to run simultaneously.

## Customization

- Change the `ProfileName` variable at the top of the script to create and launch different Discord profiles.
- If Discord is installed in a non-default location, modify the `DiscordBase` variable at the top of the script to reflect the correct path.
