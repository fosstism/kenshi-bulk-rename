param (
    [Parameter(Mandatory=$true)]
    [Alias("d")]
    [string]$Directory
)

# verify the target directory exists
if (-not (Test-Path -Path $Directory -PathType Container)) {
    Write-Host "Directory not found: $Directory" -ForegroundColor Red
    exit
}

# retrieve all subdirectories within the target directory
$subfolders = Get-ChildItem -Path $Directory -Directory

foreach ($folder in $subfolders) {
    # check for a .mod file inside the folder
    $modFile = Get-ChildItem -LiteralPath $folder.FullName -Filter *.mod | Select-Object -First 1

    if ($modFile) {
        $modFileName = $modFile.BaseName
        
        # build the expected new path to check if it exists
        $newPath = Join-Path -Path $folder.Parent.FullName -ChildPath $modFileName
    
        # check for correct names, duplicates, and process successful renames
        if ($folder.Name -eq $modFileName) {
            Write-Host "Skipping: '$($folder.Name)' has correct filename" -ForegroundColor DarkGray
        } elseif (Test-Path -LiteralPath $newPath) {
            Write-Host "Skipping: '$($folder.Name)' shares .mod filename with an existing folder '$modFileName'" -ForegroundColor LightGray
        } else {
            Rename-Item -LiteralPath $folder.FullName -NewName $modFileName
            Write-Host "'$($folder.Name)' renamed to '$modFileName'" -ForegroundColor Green
        }
    } else {
        # if no .mod exists, check for configuration file from previously subscribed mod
        $iniFile = Get-ChildItem -LiteralPath $folder.FullName -Filter *.ini | Select-Object -First 1
        
        if ($iniFile) {
            Write-Host "Warning: No .mod found in folder '$($folder.Name)' which contains possible configuration file '$($iniFile.Name)'" -ForegroundColor Yellow
        } else {
            Write-Host "Warning: No .mod found in folder '$($folder.Name)'" -ForegroundColor LightYellow
        }
    }
}

cmd.exe /c pause