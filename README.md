# Multi-Discord

This batch script allows you to launch the latest installed version of Discord with the `--multi-instance` flag. This flag enables you to run multiple instances of Discord on your system.

## How It Works

1. The script searches the `%localappdata%\Discord` directory for all installed Discord versions.
2. It identifies the latest version of Discord by checking the version numbers in the folder names.
3. Once the latest version is determined, it checks for the existence of the `Discord.exe` file in that version's folder.
4. If the executable is found, it launches Discord with the `--multi-instance` argument.
5. If Discord is not installed or the executable is not found, the script displays an appropriate message.

## Usage

1. Download or copy the batch script.
2. Save the file with a `.bat` extension (e.g., `launch_discord_multi_instance.bat`).
3. Double-click the `.bat` file to run it.

The script will automatically detect the latest installed version of Discord and attempt to launch it with the `--multi-instance` flag.

## Error Handling

- If Discord is not installed in `%localappdata%\Discord`, the script will notify you that Discord is not installed.
- If the executable file for the latest version of Discord is not found, you will receive a message stating that the executable for the specific version was not found.

## Notes

- Ensure that you have Discord installed in the default `%localappdata%\Discord` directory.
- The script is designed for Windows operating systems.

## Customization

- If you have Discord installed in a non-default location, modify the `DiscordPath` variable at the top of the script to reflect the correct path.
