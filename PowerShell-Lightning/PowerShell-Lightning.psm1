function InstalledStatusPrint {
    param (
        [parameter(Mandatory = $false, Position = 0, ParameterSetName = "Print")]
        [string]$Name,
        [parameter(Mandatory = $false, Position = 1, ParameterSetName = "Print")]
        [string]$Type,
        [parameter(Mandatory = $false, Position = 2, ParameterSetName = "Print")]
        [bool]$Status
    )

    $emojiTrue = [char]::ConvertFromUtf32(0x2714)
    $emojiFalse = [char]::ConvertFromUtf32(0x274C)

    Write-Host "$Name" -NoNewline
    Write-Host "| $Type`t" -NoNewline
    if ($Status -eq $true) {
        Write-Host $emojiTrue -ForegroundColor Green
    }
    else {
        Write-Host $emojiFalse -ForegroundColor Red
    }
    
}

Function New-Project {
    param(
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = "Create")]
        [string[]]$Create
    )

    $Name, $Type, $Argx = $Create.Split(" ")

    mkdir $Name
    $currDir = Get-Location
    Set-Location $currDir\$Name

    if ($Type.ToLower() -eq 'py' -or $Type.ToLower() -eq 'python') {
        New-Item Requirements.txt
        New-Item main.py
        PSL -gitignore python
        
        $isCode = Read-Host "Wanna open with VS Code [y/n]"
        if ($isCode.ToLower() -eq 'y') {
            code .
        }
    }
    elseif ($Type.ToLower() -eq 'js' -or $Type.ToLower() -eq 'node') {
        if ($Argx -eq "-y") {
            npm init $Argx
            New-Item index.js
        }
        else {
            npm init
        }
        PSL -gitignore node
        
        $isCode = Read-Host "Wanna open with VS Code [y/n]"
        if ($isCode.ToLower() -eq 'y') {
            code .
        }
    }
    elseif ($Type.ToLower() -eq 'cpp' -or $Type.ToLower() -eq 'c++') {
        if ($Argx -eq "-y") {
            $cppString = "#include <iostream>`nusing namespace std;`n`nint main() {`n`tcout << `"Hello World!`" << endl;`n`treturn 0;`n}"
            & { Write-Output $cppString > main.cpp }
        }
        else {
            New-Item main.cpp
        }
        PSL -gitignore cpp

        $isCode = Read-Host "Wanna open with VS Code [y/n]"
        if ($isCode.ToLower() -eq 'y') {
            code .
        }
    }
}

Function Get-Doctor {
    param(
        [Parameter(Mandatory = $false, Position = 0, ParameterSetName = "Doctor")]
        [string[]]$Doctor
    )

    $Function, $Language = $Doctor.Split(" ")

    if ($Function -eq "") {
        Write-Host "Doctor is running... 🩺"  -ForegroundColor Blue
        # PSL -Info doctor -Remaining touch
        PSL -Info doctor -Remaining nano
        PSL -Info doctor -Remaining makk
    }
    elseif ($Function.ToLower() -eq 'nano') {
        Write-Host "`nFunction: nano" -ForegroundColor Yellow
        [bool]$isInstalled = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Where-Object { $_.DisplayName -like "*Git*" })
        if (-Not $isInstalled) {
            InstalledStatusPrint "Git`t`t" installed $false
        }
        else {
            InstalledStatusPrint "Git`t`t" installed $true
        }
    }
    elseif ($Function.ToLower() -eq 'makk') {
        
        if ($null -eq $Language) {
            Write-Host "`nFunction: makk" -ForegroundColor Yellow
            PSL doctor makk python
            PSL doctor makk node
            PSL doctor makk dotnet
            PSL doctor makk cpp
        }
        else {
            if ($Language.ToLower() -eq 'py' -or $Language.ToLower() -eq 'python') {
                [bool]$isInstalled = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Where-Object { $_.DisplayName -like "*Python*" })
                if (-Not $isInstalled) {
                    InstalledStatusPrint "Python`t`t" installed $false
                }
                else {
                    InstalledStatusPrint "Python`t`t" installed $true
                }
                        
                $version = & { python -V } 2>$1
                if ($null -ne $version) {
                    InstalledStatusPrint "$version`t" configured $true
                }
                else {
                    InstalledStatusPrint "Python`t`t" configured $false
                            
                }
            }
            elseif ($Language.ToLower() -eq 'js' -or $Language.ToLower() -eq 'javascript' -or $Language.ToLower() -eq 'node') {
                [bool]$isInstalled = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Where-Object { $_.DisplayName -eq "Node.js" })
                if (-Not $isInstalled) {
                    InstalledStatusPrint "Node`t`t" installed $false
                }
                else {
                    InstalledStatusPrint "Node`t`t" installed $true
                }
                        
                $version = & { node -v } 2>$1
                if ($null -ne $version) {
                    InstalledStatusPrint "Node $version`t" configured $true
                }
                else {
                    InstalledStatusPrint "Node`t`t" configured $false
                                
                }
            }
            elseif ($Language.ToLower() -eq 'dotnet') {
                $version = & { dotnet --version } 2>$1
                if ($null -ne $version) {
                    InstalledStatusPrint "Dotnet $version`t" configured $true
                }
                else {
                    InstalledStatusPrint "Dotnet`t`t" configured $false
                }
            }
            elseif ($Language.ToLower() -eq 'cpp' -or $Language.ToLower() -eq 'c++' -or $Language.ToLower() -eq 'g++') {
                $version = & { g++ --version } 2>$1
                if ($null -ne $version) {
                    InstalledStatusPrint "g++`t`t" configured $true
                }
                else {
                    InstalledStatusPrint "g++ (for C++)`t" configured $false
                }
            }
        }
    }
}

function PSL {
    param (
        [parameter(Mandatory = $false, Position = 0, ParameterSetName = "Info")]
        [ValidateSet('info', 'doctor', 'create')]
        [string]$Info,

        [parameter(Mandatory = $false, Position = 1, ParameterSetName = "Info", ValueFromRemainingArguments)]
        [string[]]$Remaining,
        
        [Parameter(Mandatory = $false, ParameterSetName = "gitignore")]
        [string[]]
        $gitignore

    )

    [string]$gitignoreSource = "https://raw.githubusercontent.com/github/gitignore/master"

    if ($null -ne $Info) {
        if ($Info.ToLower() -eq "info") {
            Write-Host "A Quick Documentation for PowerShell-Lightning ⚡`n" -ForegroundColor Blue

            #Functions
            Write-Host "Main Functions are ->"
            
            Write-Host "`ttouch`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To create a file"

            Write-Host "`tnano`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To edit s text file"

            Write-Host "`tmakk`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To run a code | eg " -NoNewline
            Write-Host "makk hello.cpp" -ForegroundColor Yellow

            # Arguments
            Write-Host "`nArguments ->"

            Write-Host "`t-gitignore`t" -NoNewline -ForegroundColor Yellow
            Write-Host "add .gitignore file | eg " -NoNewline
            Write-Host "PSL -gitignore node" -ForegroundColor Yellow

            Write-Host "`n"

            Write-Host "`tinfo`t" -NoNewline -ForegroundColor Yellow
            Write-Host "display the docs"

            Write-Host "`tdoctor`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To check setup status | eg " -NoNewline
            Write-Host "PSL doctor" -NoNewline -ForegroundColor Yellow
            Write-Host " or " -NoNewline
            Write-Host "PSL doctor make py" -ForegroundColor Yellow

            Write-Host "`tcreate`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To create new project | eg " -NoNewline
            Write-Host "PSL create hello_js node" -ForegroundColor Yellow

            Write-Host "`n"
            Write-Host "GitHub " -NoNewline
            Write-Host "https://github.com/tasnimzotder/PowerShell-Lightning"
        }
        elseif ($Info.ToLower() -eq "create") {
            if ($null -ne $Remaining) {
                New-Project "$Remaining"
            }
            else {
                Write-Host "Plase enter the correct arguments"
                Write-Host "PSL create FileName Type Args" -ForegroundColor Yellow
            }
        }
        elseif ($Info.ToLower() -eq "doctor") {
            Get-Doctor "$Remaining"
        }
    }

    if ($null -ne $gitignore) {
        $gitignoreCap = (Get-Culture).TextInfo.ToTitleCase($gitignore.ToLower())

        if ($gitignore.ToUpper() -eq "CPP") {
            Write-Output $gitignoreCap
            Start-BitsTransfer -Source "$gitignoreSource/C%2B%2B.gitignore" -Destination ".gitignore"
        }
        else {
            Write-Output $gitignoreCap
            Start-BitsTransfer -Source "$gitignoreSource/$gitignoreCap.gitignore" -Destination ".gitignore"
        }
    }

}

# Export-ModuleMember -Function PSL