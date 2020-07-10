# add this function to profile.ps1 located in ...\\Documents\\PowerShell


function nano($value) {
    $value = $value -replace "\\", "/" -replace " ", "\ "
    bash -c "nano $value"
}