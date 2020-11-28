Write-Progress "Stating to copy files ✨"
Start-Sleep -Milliseconds 500

$target_folder = "C:\\Users\\$env:USERNAME\\OneDrive\\Documents\\PowerShell\\Modules"
$module_name = "PowerShell-Lightning"

if ((Test-Path -Path $target_folder) -ne $true) {
    & `mkdir $target_folder`
}


if (Test-Path -Path "$target_folder\\$module_name") {
    [string]$value = Read-Host "File exists | To override type 'Y'"
    if ($value.ToUpper() -eq "Y") {
        Get-ChildItem -Path "$target_folder\\$module_name\\*" -Recurse | Remove-Item -Force -Recurse
        Remove-Item "$target_folder\\$module_name"
        Copy-Item ".\$module_name" -Destination $target_folder -Recurse
        return
    }
    else {
        return
    }
}

Copy-Item ".\$module_name" -Destination $target_folder -Recurse

Write-Progress "Successfully installed 🎉"
Start-Sleep -Milliseconds 500