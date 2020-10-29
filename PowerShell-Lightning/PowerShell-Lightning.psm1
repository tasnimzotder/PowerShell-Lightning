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

    $Type, $Name, $Argx = $Create.Split(" ")

    if ($null -like $Name) {
        $Name = Read-Host "Enter project name"
    }

    if ($Type.ToLower() -eq "node") {
        if ($null -like $Name) {
            Write-Host "`nEnter project Name" -ForegroundColor Yellow
            Write-Host "`n`tFor Example -" -NoNewline
            Write-Host "`n`n`tpsl create node " -NoNewline -ForegroundColor Green
            Write-Host "my-app`n`n" -NoNewline -ForegroundColor Yellow
        }
        else {
            mkdir $Name
            $CurrDir = Get-Location
            Set-Location $CurrDir\$Name

            npm init $Argx

            psl gi node

            $foo_package = Get-Content -Raw -Path package.json | ConvertFrom-Json

            if ($foo_package.main) {
                New-Item $foo_package.main
            }
            if ($foo_package.author) {
                Write-Host "Hack it $foo_package.author"
            }
            $openVSC = Read-Host "Wanna open in VS Code? (y/N)"
            if ($openVSC.ToLower() -eq "y") {
                code .
            }
        }
    }
    elseif ($Type.ToLower() -eq "express") {
        if ($null -like $Name) {
            Write-Host "`nEnter project Name" -ForegroundColor Yellow
            Write-Host "`n`tFor Example -" -NoNewline
            Write-Host "`n`n`tpsl create express " -NoNewline -ForegroundColor Green
            Write-Host "my-app`n`n" -NoNewline -ForegroundColor Yellow
        }
        else {
            mkdir $Name
            $CurrDir = Get-Location
            Set-Location $CurrDir\$Name

            npm init $Argx

            npm install express
            $isNodemon = Read-Host "Wanna Nodemon? (y/N)"
            if ($isNodemon.ToLower() -eq "y") {
                npm install --save-dev nodemon
            }
            psl gi node

            $foo_package = Get-Content -Raw -Path package.json | ConvertFrom-Json

            if ($foo_package.main) {
                New-Item $foo_package.main
            }
            if ($foo_package.author) {
                Write-Host "Hack it $foo_package.author"
            }
            $openVSC = Read-Host "Wanna open in VS Code? (y/N)"
            if ($openVSC.ToLower() -eq "y") {
                code .
            }
        }
    }
    elseif ($Type.ToLower() -eq "py" -or $Type.ToLower() -eq "python") {
        if ($null -like $Name) {
            Write-Host "`nEnter project Name" -ForegroundColor Yellow
            Write-Host "`n`tFor Example -" -NoNewline
            Write-Host "`n`n`tpsl create py " -NoNewline -ForegroundColor Green
            Write-Host "my-app`n`n" -NoNewline -ForegroundColor Yellow
        }
        else {
            $OOS = New-Object System.Management.Automation.Host.ChoiceDescription '&One-Off Script', 'One-Off Script'
            $ISP = New-Object System.Management.Automation.Host.ChoiceDescription '&Installable Single Package', 'Installable Single Package'
            
            $options = [System.Management.Automation.Host.ChoiceDescription[]]($OOS, $ISP)
            $message = 'Select the python project structure - '
            $result = $Host.UI.PromptForChoice('', $message, $options, 0)
        
            switch ($result) {
                0 { 
                    mkdir $Name
                    $CurrDir = Get-Location
                    Set-Location $CurrDir\$Name

                    Write-Output "## $Name" > README.md
                    New-Item "$Name.py", requirements.txt, setup.py, tests.py
                    psl gi python
                }
                1 { 
                    mkdir $Name
                    $CurrDir = Get-Location
                    Set-Location $CurrDir\$Name
                    # $CurrDir_r = Get-Location

                    mkdir $Name, tests
                    # Set-Location $CurrDir_r\$Name

                    New-Item requirements.txt, setup.py, $name\__init__.py, "$name`\$Name.py", $name\helpers.py, "tests\$Name`_tests.py", "tests\helpers_tests.py"

                    # Set-Location $CurrDir_r/tests
                    # New-Item "$Name`_tests.py", helpers_tests.py
                    
                    # Set-Location $CurrDir_r
                    
                    
                    Write-Output "## $Name" > README.md
                    # New-Item requirements.txt, setup.py
                    psl gi python
                }
            }
        }
    }
    elseif ($Type.ToLower() -eq "web") {
        $w_html = New-Object System.Management.Automation.Host.ChoiceDescription '&HTML', 'Simple HTML project'
        $w_react = New-Object System.Management.Automation.Host.ChoiceDescription '&REACT', 'React front end project'
        
        $options = [System.Management.Automation.Host.ChoiceDescription[]]($w_html, $w_react)
        $message = 'Select the web project structure - '
        $result = $Host.UI.PromptForChoice('', $message, $options, 0)

        switch ($result) {
            0 {
                mkdir $Name
                $CurrDir = Get-Location
                Set-Location $CurrDir\$Name
                # $CurrDir_r = Get-Location

                mkdir assets, scripts, styles
                mkdir assets\images, assets\fonts

                New-Item scripts\script.js, styles\style.css
                $html_text = "<!DOCTYPE html>`n<html lang=`"en`">`n`t<head>`n`t`t<meta charset=`"UTF-8`" />`n`t`t<meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0`" />`n`t`t<title>PSL - In Smart way</title>`n`t`t<link rel=`"shortcut icon`" href=`"assets/favicon.ico`" type=`"image/x-icon`">`n`t`t<link rel=`"stylesheet`" href=`"./styles/style.css`">`n`t`t<script src=`"./scripts/script.js`"></script>`n`t</head>`n`t<body>`n`t`t<h1 align=`"center`">Hello World</h1>`n`t</body>`n</html>"
                $favicon_link = "https://storage.googleapis.com/tasnim-dev.appspot.com/psl/favicon.ico"
                Write-Output $html_text > index.html 
                Start-BitsTransfer -Source $favicon_link -Destination assets/favicon.ico
            }1 {

            }
        }
    }

    # mkdir $Name
    # $currDir = Get-Location
    # Set-Location $currDir\$Name

    # if ($Type.ToLower() -eq 'py' -or $Type.ToLower() -eq 'python') {
    #     New-Item Requirements.txt
    #     New-Item main.py
    #     PSL -gitignore python
        
    #     $isCode = Read-Host "Wanna open with VS Code [y/n]"
    #     if ($isCode.ToLower() -eq 'y') {
    #         code .
    #     }
    # }
    # elseif ($Type.ToLower() -eq 'js' -or $Type.ToLower() -eq 'node') {
    #     if ($Argx -eq "-y") {
    #         npm init $Argx
    #         New-Item index.js
    #     }
    #     else {
    #         npm init
    #     }
    #     PSL -gitignore node
        
    #     $isCode = Read-Host "Wanna open with VS Code [y/n]"
    #     if ($isCode.ToLower() -eq 'y') {
    #         code .
    #     }
    # }
    # elseif ($Type.ToLower() -eq 'cpp' -or $Type.ToLower() -eq 'c++') {
    #     if ($Argx -eq "-y") {
    #         $cppString = "#include <iostream>`nusing namespace std;`n`nint main() {`n`tcout << `"Hello World!`" << endl;`n`treturn 0;`n}"
    #         & { Write-Output $cppString > main.cpp }
    #     }
    #     else {
    #         New-Item main.cpp
    #     }
    #     PSL -gitignore cpp

    #     $isCode = Read-Host "Wanna open with VS Code [y/n]"
    #     if ($isCode.ToLower() -eq 'y') {
    #         code .
    #     }
    # }
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
        [ValidateSet('info', 'doctor', 'create', 'c', 'gitignore', 'gi')]
        [string]$Info,

        [parameter(Mandatory = $false, Position = 1, ParameterSetName = "Info", ValueFromRemainingArguments)]
        [string[]]$Remaining
        
        # [Parameter(Mandatory = $false, ParameterSetName = "gitignore")]
        # [string[]]
        # $gitignore

    )

    if ($null -like $Info) {
        PSL info
    }

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
            
            Write-Host "`tgi" -NoNewline -ForegroundColor Yellow
            Write-Host ", " -NoNewline
            Write-Host "gitignore`t" -NoNewline -ForegroundColor Yellow
            Write-Host "add .gitignore file | eg " -NoNewline
            Write-Host "PSL gi node" -ForegroundColor Yellow

            Write-Host "`n"
            Write-Host "GitHub " -NoNewline
            Write-Host "https://github.com/tasnimzotder/PowerShell-Lightning"
        }
        elseif ($Info.ToLower() -eq "create" -or $Info.ToLower() -eq "c") {
            if ($null -ne $Remaining) {
                New-Project "$Remaining"
            }
            else {
                # Write-Host "Plase enter the correct project type" -ForegroundColor Yellow
                # Write-Host "`n`tFor Example - " -NoNewline
                # Write-Host "node, python, web, cpp, react, express`n" -ForegroundColor Green
                $node_x = New-Object System.Management.Automation.Host.ChoiceDescription '&Node', 'Node Application'
                $py_x = New-Object System.Management.Automation.Host.ChoiceDescription '&Python', 'Python Application'
                $web_x = New-Object System.Management.Automation.Host.ChoiceDescription '&Web', 'Website'
                
                $options = [System.Management.Automation.Host.ChoiceDescription[]]($node_x, $py_x, $web_x)
                $message = "`nSelect the project type - "
                $result = $Host.UI.PromptForChoice('', $message, $options, 0)

                switch ($result) {
                    0 {
                        psl create node
                    } 1 {
                        psl create python
                    } 2 {
                        psl create web
                    }
                }
            }
        }
        elseif ($Info.ToLower() -eq "doctor") {
            Get-Doctor "$Remaining"
        }
        elseif ($Info.ToLower() -eq "gitignore" -or $Info.ToLower() -eq "gi") {
            if ($null -eq $Remaining) {
                [string]$Remaining = Read-Host "Enter the project type (node, cpp, python ... )"
            }
            
            [string]$gitignoreSource = "https://raw.githubusercontent.com/github/gitignore/master"
            $gitignoreCap = (Get-Culture).TextInfo.ToTitleCase($Remaining.ToLower())


            if ($Remaining.ToUpper() -eq "CPP") {
                Write-Output ".gitignore for $gitignoreCap project"
                Start-BitsTransfer -Source "$gitignoreSource/C%2B%2B.gitignore" -Destination ".gitignore"
            }
            else {
                Write-Output ".gitignore for $gitignoreCap project"
                Start-BitsTransfer -Source "$gitignoreSource/$gitignoreCap.gitignore" -Destination ".gitignore"
            }
        }
    }

    # if ($null -ne $gitignore) {
    #     $gitignoreCap = (Get-Culture).TextInfo.ToTitleCase($gitignore.ToLower())

    #     if ($gitignore.ToUpper() -eq "CPP") {
    #         Write-Output $gitignoreCap
    #         Start-BitsTransfer -Source "$gitignoreSource/C%2B%2B.gitignore" -Destination ".gitignore"
    #     }
    #     else {
    #         Write-Output $gitignoreCap
    #         Start-BitsTransfer -Source "$gitignoreSource/$gitignoreCap.gitignore" -Destination ".gitignore"
    #     }
    # }

}

# Export-ModuleMember -Function PSL
Set-Alias -Name PSL gitignore -Value PSL gi