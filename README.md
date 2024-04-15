# Dot Files

### creating symlinks

This script `create-symlinks.sh` is meant to create symbolic links (or symlinks) for directory files in various locations onto the home directory. This is useful for maintaining dotfiles across various systems.

Before running the script, keep in mind that there's the possibility to run a "--dry-run" argument. This argument outputs the actions the script will take without affecting any change on the filesystem (simulation). No argument assumes a real run.

## Usage:

```zsh
    ./create-symlinks.sh [--dry-run]
```

Optionally, add the `--dry-run` at end of the command to simulate the process without making any change on the filesystem.

`DRY_RUN` is a boolean value set to `0` by default. If `--dry-run` is passed, then it is set to `1`.

The script's primary location of interest is the home directory's ".dot_files". Several defined global variables help regulate symlink generation process:

    - IGNORED_FILES: An array of filenames that should be ignored during the symlink process.
    - EXCLUDED_DIRS: Array of directories to exclude from the symlink process.
    - SYMLINK_MAP: An associative array holding specific symlinks to be made.

## Symlink Process:

The script carries out the symlink process in three key stages:

##### 1. Dotfiles in the Home Directory

The script goes through each item under the `.dot_files` directory of the user's home. It loops through each file (ignoring those from the exclude list),"removes" and re-creates its symlink counterpart linked to the home directory.

##### 2. Dotfiles in the `.config` Subdirectory

Besides files in the `.dot_files` parent directory, the script also handles those inside its subdirectory, `.config`. Similar to how it operates on the parent directory, in this stage it removes(if exist) and creates fresh symlinks for each subdirectory.

##### 3. Create Specific Symlinks

There might be instances where a specific mapping of symlinks is beneficial. The latter stage of the script caters to this requirement. The script sweeps through an associative array `SYMLINK_MAP` (holding such mappings). For every key-value pair, the script would create a symlink of the `filepath/key` with its corresponding `value`.

Bear in mind with each of these three stages, the `--dry-run` mode only logs the actions without performing them as actual system operations.

## Logging:

Besides actions intended to be carried out, the script intermittently produces status reports to the terminal. This helps for casual monitoring of the symlink process.

To set up symlinks run
