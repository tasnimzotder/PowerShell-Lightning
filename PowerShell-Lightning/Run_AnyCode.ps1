function Run_AnyCode {
    param(
        [Parameter(Mandatory = $true)]
        [string]$value
    )

    if (Test-Path $value -PathType Leaf) {
        if ($value -like "*.cpp") {
            $value = Split-Path $value -LeafBase

            $build_cmd = "& g++ $value.cpp -o $value"
            $run_cmd = $null
        }
        elseif ($value -like "*.py") {
            $value = Split-Path $value -LeafBase
            
            $build_cmd = $null
            $run_cmd = "& python $value.py"
        }
        elseif ($value -like "*.js") {
            $value = Split-Path $value -LeafBase
            $build_cmd = $null
            $run_cmd = "& node $value.js"
        }
        elseif ($value -like "*.ts") {
            $value = Split-Path $value -LeafBase
            
            $build_cmd = "& tsc $value.ts"
            $run_cmd = "& node $value.js"
        }
        elseif ($value -like "*.cs") {
            $value = Split-Path $value -LeafBase

            $build_cmd = "& csc $value.cs"
            $run_cmd = $null
        }
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
    
    if ($null -ne $build_cmd) {
        Write-Progress "Building... ⌛"
        Invoke-Expression $build_cmd
    }
    
    $stopwatch_b.Stop()
    $stopwatch_r.Start()
    
    if ($null -ne $run_cmd) {
        Write-Progress "Running... ⚡"
        Invoke-Expression $run_cmd
    }
    elseif (Test-Path "$value.exe" -PathType Leaf) {
        Write-Progress "Starting to run... ⚡"
        Start-Sleep -Milliseconds 100
        Invoke-Expression "& .\$value.exe"
        Remove-Item "$value.exe"
    }

    $stopwatch_r.Stop()

    $time_b_diff = $stopwatch_b.ElapsedMilliseconds
    $time_r_diff = $stopwatch_r.ElapsedMilliseconds
    
    Write-Host "`n⌛ Build time $time_b_diff milliseconds"
    Write-Host "⚡ Run time   $time_r_diff milliseconds`n"
}

Set-Alias -Name makk -Value Run_AnyCode