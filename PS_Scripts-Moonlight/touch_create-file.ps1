function touch {
    param (
        [Parameter(Mandatory = $true)] 
        [string]$value
    )

    if (Test-Path -LiteralPath $value) {
        (Get-Item -Path $value).LastWriteTime = Get-Date
    }
    else {
        New-Item -Type File -Path $value
    }
}