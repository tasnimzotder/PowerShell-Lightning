# add this function to profile.ps1 located in ...\\Documents\\PowerShell


function makk {
    param(
        [Parameter(Mandatory = $true)]
        [string]$value
    )


    if (($value -like "*.cpp") -or (Test-Path "$value.cpp" -PathType Leaf)) {
        $value = Split-Path $value -LeafBase
        $build_cmd = "& g++ $value.cpp -o $value"
    }
    elseif (($value -like "*.py") -or (Test-Path "$value.py" -PathType Leaf)) {
        $value = Split-Path $value -LeafBase
        $build_cmd = "& python $value.py"
    }
    elseif (($value -like "*.js") -or (Test-Path "$value.js" -PathType Leaf)) {
        $value = Split-Path $value -LeafBase
        $build_cmd = "& node $value.js"
    }
    elseif (($value -like "*.ts") -or (Test-Path "$value.ts" -PathType Leaf)) {
        $value = Split-Path $value -LeafBase
        $build_cmd = "& ts-node $value.ts"
    }
    elseif (($value -like "*.cs") -or (Test-Path "$value.cs" -PathType Leaf)) {
        $value = Split-Path $value -LeafBase
        $build_cmd = "& csc $value.cs"
    }
    else {
        Write-Host "`n    😟 No file found!`n"
        [string]$value_x = Read-Host "😎 Create the file [Y/N] (default N)"
        if ($value_x -eq "Y" -or $value_x -eq "y") {
            Invoke-Expression "& nano $value"
            return
        }
        Write-Host "Bye 👋"
        return
    }

    # Write-Host "🍦 Output goes here...⤵️`n"
    Write-Host "⤵"

    $stopwatch_b = New-Object System.Diagnostics.Stopwatch
    $stopwatch_r = New-Object System.Diagnostics.Stopwatch
    $stopwatch_b.Start()

    # Invoke-Expression "& g++ $value.cpp -o $value"
    Invoke-Expression $build_cmd

    $stopwatch_b.Stop()
    $stopwatch_r.Start()
    
    if (Test-Path "$value.exe" -PathType Leaf) {
        Invoke-Expression "& .\$value.exe"
        Remove-Item "$value.exe"
    }

    $stopwatch_r.Stop()

    $time_b_diff = $stopwatch_b.ElapsedMilliseconds
    $time_r_diff = $stopwatch_r.ElapsedMilliseconds
    
    Write-Host "`n⌛ Build time $time_b_diff milliseconds"
    Write-Host "⚡ Run time   $time_r_diff milliseconds`n"
}