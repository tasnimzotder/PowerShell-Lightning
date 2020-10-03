function Run_AnyCode {
    param(
        [Parameter(Mandatory = $true)]
        [string]$value,

        [switch]$s,
        [switch]$silent,

        [switch]$p,
        [switch]$progress

        # [Parameter(Mandatory = $false, ParameterSetName = "gitignore")]
        # [string[]]
        # $gitignore
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

    if ( !($s -or $silent)) {
        Write-Host "⤵"
    }

    $stopwatch_b = New-Object System.Diagnostics.Stopwatch
    $stopwatch_r = New-Object System.Diagnostics.Stopwatch

    $stopwatch_b.Start()
    
    if ($null -ne $build_cmd) {
        if ($progress -or $p) {
            Write-Progress "Building... ⌛"
        }
        Invoke-Expression $build_cmd
    }
    
    $stopwatch_b.Stop()
    $stopwatch_r.Start()
    
    if ($null -ne $run_cmd) {
        if ($progress -or $p) {
            Write-Progress -Activity "Running... ⚡" -Status "Please wait"
        }
        Invoke-Expression $run_cmd
    }
    elseif (Test-Path "$value.exe" -PathType Leaf) {
        if ($progress -or $p) {
            Write-Progress -Activity "Starting to run... ⚡" -Status "Please wait"
        }
        Start-Sleep -Milliseconds 100
        Invoke-Expression "& .\$value.exe"
        Remove-Item "$value.exe"
    }

    $stopwatch_r.Stop()

    if (!($silent -or $s)) {   
        $time_b_diff = $stopwatch_b.ElapsedMilliseconds
        $time_r_diff = $stopwatch_r.ElapsedMilliseconds
        
        Write-Host "`n⌛ Build time $time_b_diff milliseconds"
        Write-Host "⚡ Run time   $time_r_diff milliseconds`n"
    }

}

Set-Alias -Name makk -Value Run_AnyCode
# SIG # Begin signature block
# MIIFwgYJKoZIhvcNAQcCoIIFszCCBa8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUvLFzom1EaQkdi6ZaSCUxX0vS
# Ly6gggNLMIIDRzCCAjOgAwIBAgIQhiXs6awyFqFPm3GUeR/E0TAJBgUrDgMCHQUA
# MCwxKjAoBgNVBAMTIVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0yMDA3MTExNzM1MThaFw0zOTEyMzEyMzU5NTlaMCMxITAfBgNVBAMTGFBvd2Vy
# U2hlbGwgVGFzbmltLVpvdGRlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
# ggEBANRp2DYg1OkCh6u37EASAuwkwmNjVnoonWvdmyQenR1cbV8fZSPFujhO2OZz
# /NNJqP4I3vy9ZD0567JBiWqklESMv3vu7um0L6m/CFk/Jw6sXzT1/ktb6r/+4Q/k
# OROLpCZpq54Sxhc+M21tatB6qHmqyioN4w5l/5lM4fulcA3xj8b5JNEKGFNCL9QV
# Lk0kdfxnZQZ8nOX7FSARAty+ciGcPUXZywNBmdl0sV6MEDjk2QesqLJ3A/kIQ5bN
# dh8zS3v8YWJO1cs4DWtcJm/O54Wve6Kx+6UW5tJDJTwV9odAqfSEGsGCia77xdFq
# ljUVpI095A8nDkZXpxMhLMXY3HECAwEAAaN2MHQwEwYDVR0lBAwwCgYIKwYBBQUH
# AwMwXQYDVR0BBFYwVIAQJJrB//PzkZSRACuhyg6k7qEuMCwxKjAoBgNVBAMTIVBv
# d2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdIIQCWDLzayPlJdIZSFywc56
# xzAJBgUrDgMCHQUAA4IBAQCNuHeASv1d2yZhusDN7YtvI4R8b/QNO42UZAh5FAHB
# xtuKaeG4I2sbbwpBVR2V0TilRiJxC2ENbi1h9tw8nwNuHOPsXYmfkpNoCAy2uLMA
# nRPqJU3BkSlzXpyOpYUcyPzWtwIkSA+3bMBLF6TJPpcvHGdL8Z/bCi40garSZxgW
# dMj2h75+ZswzInZWG1ptuY6+w9lXIZT5jIfcRi5XuhmcH358xPTBdlRaO4DoYcVt
# 5YKtUlwId1MwuqaA5IMqkjowTCHr/T1aH60d48z1oSntjLz/1rvSUgKOz5Plk4d3
# 0ut469ruQ7WHTrgz6R7HJK5aeWQ8B7NpgaGaFGSOKpupMYIB4TCCAd0CAQEwQDAs
# MSowKAYDVQQDEyFQb3dlclNoZWxsIExvY2FsIENlcnRpZmljYXRlIFJvb3QCEIYl
# 7OmsMhahT5txlHkfxNEwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKA
# AKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFHNMM7eFNmXN/GTEt9s8Ut3v
# rQsMMA0GCSqGSIb3DQEBAQUABIIBAA3m2CVZO9zLtc4a/o925oAoOo8RwaGvT3jN
# lAQV228uWXVIIs8xcFbasd1KjM/idnn4oKuBOej7Ck1VOeYF1zN/tR2EGxh9OxbA
# +MgcwiHqDVo2wlxypUzFDweyUKMKunPmfRBHT1nKfPQgzCDDmmLRQb6XM6ROhyaZ
# u3zZeHXaCbXmNwC16Akap09dPDNRlB2vFoSysWMzmvS4x7JdOjRrxLsGIRdMbPmT
# l52CpR9MH6fGhdv3WWwepZbRd/W+ihifj7FFD+n4O9AMbz6p9WX3JPIIsaX4IZCr
# XsVmTkrTRCO/G64eAdBZck9HwLZcirmual1ZSpCozWdWa9D1vfQ=
# SIG # End signature block
