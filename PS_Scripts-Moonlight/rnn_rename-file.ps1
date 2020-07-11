function rnn() {
    param (
        [Parameter(Mandatory = $true)]
        [string]$value
    )

    [string]$new_value = Read-Host "Enter new name"

    Rename-Item $value -NewName $new_value
}