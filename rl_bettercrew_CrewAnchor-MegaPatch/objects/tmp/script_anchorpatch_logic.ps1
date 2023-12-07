# Assuming the script is in the same directory as the files
$directory = Get-Location
$objectExtension = ".object"
$patchExtension = ".patch"
$binFileName = "script_anchorpatch_data.bin"

# Change the extension of all .object files to .object.patch
Get-ChildItem -Path $directory -Filter "*$objectExtension" -File | ForEach-Object {
    $newName = $_.BaseName + $patchExtension
    Rename-Item $_.FullName -NewName $newName
}

# Replace the content of all .object.patch files with the content of the defined .bin file
$binFilePath = Join-Path $directory $binFileName
$replaceContent = Get-Content $binFilePath -Raw
Get-ChildItem -Path $directory -Filter "*$patchExtension" -File | ForEach-Object {
    $replaceContent | Set-Content $_.FullName
}
