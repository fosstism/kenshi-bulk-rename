# kenshi-bulk-rename
A simple PowerShell script for bulk renaming Kenshi mod folders from Steam Workshop IDs to match their corresponding .mod file.

- Iterates through all subfolders in a target directory
- If a folder contains a .mod file, the folder is renamed to match the .mod file
- Skips and notifies of folders with naming conflicts and folders that do not contain a .mod file
- Notifies if folder with no .mod file contains an .ini file

#### Usage

```javascript
.\kenshi-mod-renamer.ps1 -Directory <path>
.\kenshi-mod-renamer.ps1 -d <path>
```

#### Parameters

```javascript
[-Directory, -d] Path to the target directory containing the subfolders to process.
```

**
*I recommend creating a backup of your target directory before running this script*
**
