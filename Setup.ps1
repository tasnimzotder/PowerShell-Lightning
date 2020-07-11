Write-Progress "Stating to copy files 😀"
Start-Sleep -Milliseconds 500

$target_folder = "C:\\Users\\$env:USERNAME\\Documents\\PowerShell\\Modules"

if ((Test-Path -Path $target_folder) -ne $true) {
    mkdir $target_folder
}


if (Test-Path -Path "$target_folder\\PS_Scripts-Moonlight") {
    [string]$value = Read-Host "File exists | To override type 'Y'"
    if ($value.ToUpper() -eq "Y") {
        Get-ChildItem -Path "$target_folder\\PS_Scripts-Moonlight\\*" -Recurse | Remove-Item -Force -Recurse
        Remove-Item "$target_folder\\PS_Scripts-Moonlight"
        Copy-Item ".\PS_Scripts-Moonlight" -Destination $target_folder -Recurse
        return
    } else {
        return
    }
}

Copy-Item ".\PS_Scripts-Moonlight" -Destination $target_folder -Recurse

Write-Progress "Successfully installed 🙄"
Start-Sleep -Milliseconds 500