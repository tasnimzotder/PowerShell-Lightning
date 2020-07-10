# add this function to profile.ps1 located in ...\\Documents\\PowerShell


Function touch {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (Test-Path -LiteralPath $Path) {
        (Get-Item -Path $Path).LastWriteTime = Get-Date
    }
    else {
        New-Item -Type File -Path $Path
    }
}