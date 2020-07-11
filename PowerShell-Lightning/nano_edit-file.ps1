function nano($value) {
    $value = $value -replace "\\", "/" -replace " ", "\ "
    bash -c "nano $value"
}