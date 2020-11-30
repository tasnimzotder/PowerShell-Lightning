# 
#   Powershell Lightning
# 
#   Author: Tasnim Zotder <hello@tasnim.dev> | 2020
#   Repository: https://github.com/tasnimzotder/PowerShell-Lightning
#   License: MIT
# 


function InstalledStatusPrint {
    param (
        [parameter(Mandatory = $false, Position = 0, ParameterSetName = "Print")]
        [string]$Name,
        [parameter(Mandatory = $false, Position = 1, ParameterSetName = "Print")]
        [string]$Type,
        [parameter(Mandatory = $false, Position = 2, ParameterSetName = "Print")]
        [bool]$Status
    )

    $emojiTrue = [char]::ConvertFromUtf32(0x2714)   # tick symbol
    $emojiFalse = [char]::ConvertFromUtf32(0x274C)  # cross symbol

    Write-Host "$Name" -NoNewline
    Write-Host "| $Type`t" -NoNewline
    if ($Status -eq $true) {
        Write-Host $emojiTrue -ForegroundColor Green
    }
    else {
        Write-Host $emojiFalse -ForegroundColor Red
    }
    
}

Function Add-Setup {
    param (
        [Parameter(Mandatory = $true, Position = 0, ParameterSetName = "Setup")]
        [string[]]$Setup
    )

    if ($Setup.ToLower() -eq "python") {
        $s_pipenv = New-Object System.Management.Automation.Host.ChoiceDescription '&1-Pipenv', 'asdfg'
        $s_poetry = New-Object System.Management.Automation.Host.ChoiceDescription '&2-Poetry', 'wertyu'
        
        $options = [System.Management.Automation.Host.ChoiceDescription[]]($s_pipenv, $s_poetry)
        $message = 'Select the python project structure - '
        $result = $Host.UI.PromptForChoice('', $message, $options, 0)

        switch ($result) {
            0 {
                $currDir = Get-Location
                Write-Output "Setting up 'pipenv' in  $currDir"
                
                try {
                    try {
                        & ` export PIPENV_VENV_IN_PROJECT="enabled"`
                        & `pipenv install`

                        psl gi python

                        Write-Host "✔️ Configuration added successfully"
                    }
                    catch {
                        & `pip install pipenv`
                        & ` export PIPENV_VENV_IN_PROJECT="enabled"`
                        & `pipenv install`
                        
                        psl gi python
                        Write-Host "✔️ Configuration added successfully"
                    }
                }
                catch {
                    Write-Error "Python 3 is not setup"
                }
            }
            1 {
                $currDir = Get-Location
                Write-Output "Setting up 'poetry' in  $currDir"
                
                try {
                    try {
                        & `poetry init`
                        Write-Output "[virtualenvs]`nin-project = true" > poetry.toml
                        & `poetry install`
                        
                        psl gi python
                        Write-Host "✔️ Configuration added successfully"
                    }
                    catch {
                        (Invoke-WebRequest -Uri https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py -UseBasicParsing).Content | python -
                        & `poetry init`
                        Write-Output "[virtualenvs]`nin-project = true" > poetry.toml
                        & `poetry install`
                        
                        psl gi python
                        Write-Host "✔️ Configuration added successfully"
                    }
                }
                catch {
                    Write-Error "Failed to setup"
                }
            }
            Default {}
        }
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
            $currDir = Get-Location
            Set-Location $currDir\$Name

            npm init $Argx

            psl gi node

            $foo_package = Get-Content -Raw -Path package.json | ConvertFrom-Json

            if ($foo_package.main) {
                New-Item $foo_package.main
            }
            if ($foo_package.author) {
                Write-Host "Hack it $foo_package.author"
            }

            Write-Host "✔️ Project created successfully"

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
            $currDir = Get-Location
            Set-Location $currDir\$Name

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

            Write-Host "✔️ Project created successfully"

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
            $OOS = New-Object System.Management.Automation.Host.ChoiceDescription '&1-One-Off Script', 'One-Off Script'
            $ISP = New-Object System.Management.Automation.Host.ChoiceDescription '&2-Installable Single Package', 'Installable Single Package'
            
            $options = [System.Management.Automation.Host.ChoiceDescription[]]($OOS, $ISP)
            $message = 'Select the python project structure - '
            $result = $Host.UI.PromptForChoice('', $message, $options, 0)
        
            switch ($result) {
                0 { 
                    mkdir $Name
                    $currDir = Get-Location
                    Set-Location $currDir\$Name

                    Write-Output "## $Name" > README.md
                    New-Item "$Name.py"

                    Write-Output "Setting up pipenv"

                    & `pip install pipenv`
                    & ` export PIPENV_VENV_IN_PROJECT="enabled"`
                    & `.\venv\Scripts\activate`

                    psl gi python
                    Write-Host "✔️ Project created successfully"
                }
                1 { 
                    mkdir $Name
                    $currDir = Get-Location
                    Set-Location $currDir\$Name
                    mkdir $Name, tests

                    New-Item requirements.txt, setup.py, $name\__init__.py, "$name`\$Name.py", $name\helpers.py, "tests\$Name`_tests.py", "tests\helpers_tests.py"
                    
                    Write-Output "## $Name" > README.md
                    psl gi python
                    Write-Host "✔️ Project created successfully"
                }
            }
        }
    }
    elseif ($Type.ToLower() -eq "web") {
        $w_react = New-Object System.Management.Automation.Host.ChoiceDescription '&1-REACT', 'React front end project'
        $w_next = New-Object System.Management.Automation.Host.ChoiceDescription '&2-NEXT', 'Next.js front end project'
        $w_html = New-Object System.Management.Automation.Host.ChoiceDescription '&3-HTML', 'Simple HTML project'
        
        $options = [System.Management.Automation.Host.ChoiceDescription[]]($w_react, $w_next, $w_html)
        $message = 'Select the web project structure - '
        $result = $Host.UI.PromptForChoice('', $message, $options, 0)

        switch ($result) {
            0 {
                $currDir = Get-Location

                try {
                    & `yarn create react-app $Name`
                    Set-Location $currDir\$Name
                    Write-Host "✔️ Project created successfully"
                }
                catch {
                    try {
                        & ` npx create-react-app $Name`
                        Set-Location $currDir\$Name
                        Write-Host "✔️ Project created successfully"
                    }
                    catch {
                        Write-Error "Please install npx or yarn on your system"
                    }
                }
            } 1 {
                $currDir = Get-Location

                try {
                    & `yarn create next-app $Name`
                    Set-Location $currDir\$Name
                    Write-Host "✔️ Project created successfully"
                }
                catch {
                    try {
                        & ` npx create-next-app $Name`
                        Set-Location $currDir\$Name
                        Write-Host "✔️ Project created successfully"
                    }
                    catch {
                        Write-Error "Please install npx or yarn on your system"
                    }
                }
            } 2 {
                mkdir $Name
                $currDir = Get-Location
                Set-Location $currDir\$Name
                # $currDir_r = Get-Location

                mkdir assets, scripts, styles
                mkdir assets\images, assets\fonts

                New-Item scripts\script.js, styles\style.css
                $html_text = "<!DOCTYPE html>`n<html lang=`"en`">`n`t<head>`n`t`t<meta charset=`"UTF-8`" />`n`t`t<meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0`" />`n`t`t<title>PSL - In Smart way</title>`n`t`t<link rel=`"shortcut icon`" href=`"assets/favicon.ico`" type=`"image/x-icon`">`n`t`t<link rel=`"stylesheet`" href=`"./styles/style.css`">`n`t`t<script src=`"./scripts/script.js`"></script>`n`t</head>`n`t<body>`n`t`t<h1 align=`"center`">Hello World</h1>`n`t</body>`n</html>"
                $favicon_link = "https://storage.googleapis.com/tasnim-dev.appspot.com/psl/favicon.ico"
                Write-Output $html_text > index.html 
                Start-BitsTransfer -Source $favicon_link -Destination assets/favicon.ico
                Write-Host "✔️ Project created successfully"
            }
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
            if ($Language.ToLower() -in @("py", "python")) {                       
                $version = & { python -V } 2>$1
                if ($null -ne $version) {
                    InstalledStatusPrint "$version`t" configured $true
                }
                else {
                    InstalledStatusPrint "Python`t`t" configured $false
                            
                }
            }
            elseif ($Language.ToLower() -in @("js", "javascript", "node")) {                        
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
            elseif ($Language.ToLower() -in @("cpp", "c++", "g++")) {
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
        [ValidateSet('info', 'doctor', 'create', 'c', 'setup', 's', 'gitignore', 'gi')]
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
            Write-Host "To display the docs"
            
            Write-Host "`tdoctor`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To check setup status | eg " -NoNewline
            Write-Host "PSL doctor" -ForegroundColor Yellow
            
            Write-Host "`tcreate`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To create new project | eg " -NoNewline
            Write-Host "PSL create hello_js node" -ForegroundColor Yellow
            
            Write-Host "`tsetup`t" -NoNewline -ForegroundColor Yellow
            Write-Host "To Setup project env / config | eg " -NoNewline
            Write-Host "PSL setup" -ForegroundColor Yellow
            
            Write-Host "`tgi" -NoNewline -ForegroundColor Yellow
            Write-Host ", " -NoNewline
            Write-Host "gitignore`t" -NoNewline -ForegroundColor Yellow
            Write-Host "add .gitignore file | eg " -NoNewline
            Write-Host "PSL gi node" -ForegroundColor Yellow

            Write-Host "`n"
            Write-Host "GitHub -> " -NoNewline
            Write-Host "https://github.com/tasnimzotder/PowerShell-Lightning"  -ForegroundColor Blue
        }
        elseif ($Info.ToLower() -eq "create" -or $Info.ToLower() -eq "c") {
            if ($null -ne $Remaining) {
                New-Project "$Remaining"
            }
            else {
                # Write-Host "Plase enter the correct project type" -ForegroundColor Yellow
                # Write-Host "`n`tFor Example - " -NoNewline
                # Write-Host "node, python, web, cpp, react, express`n" -ForegroundColor Green
                $node_x = New-Object System.Management.Automation.Host.ChoiceDescription '&1-Node', 'Node Application'
                $py_x = New-Object System.Management.Automation.Host.ChoiceDescription '&2-Python', 'Python Application'
                $web_x = New-Object System.Management.Automation.Host.ChoiceDescription '&3-Web', 'Website'
                
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
        elseif ($Info.ToLower() -eq "setup" -or $Info.ToLower() -eq "s") {
            $s_python = New-Object System.Management.Automation.Host.ChoiceDescription '&1-Python', 'Python Configurations'

            $options = [System.Management.Automation.Host.ChoiceDescription[]]($s_python)
            $message = "`nSelect the configuration type - "
            $result = $Host.UI.PromptForChoice('', $message, $options, 0)

            switch ($result) {
                0 {
                    Add-Setup python
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

            [System.Collections.ArrayList]$gi_names = @('Actionscript', 'Ada', 'Agda', 'Android',
                'AppceleratorTitanium', 'AppEngine', 'ArchLinuxPackages', 'Autotools', 'C++', 'C',
                'CakePHP', 'CFWheels', 'ChefCookbook', 'Clojure', 'CMake', 'CodeIgniter',
                'CommonLisp', 'Composer', 'Concrete5', 'Coq', 'CraftCMS', 'CUDA', 'D', 'Dart',
                'Delphi', 'DM', 'Drupal', 'Eagle', 'Elisp', 'Elixir', 'Elm', 'EPiServer', 'Erlang',
                'ExpressionEngine', 'ExtJs', 'Fancy', 'Finale', 'ForceDotCom', 'Fortran', 'FuelPHP',
                'Gcov', 'GitBook', 'Go', 'Godot', 'Gradle', 'Grails', 'GWT', 'Haskell', 'Idris',
                'IGORPro', 'Java', 'JBoss', 'Jekyll', 'JENKINS_HOME', 'Joomla', 'Julia', 'KiCad',
                'Kohana', 'Kotlin', 'LabVIEW', 'Laravel', 'Leiningen', 'LemonStand', 'Lilypond',
                'Lithium', 'Lua', 'Magento', 'Maven', 'Mercury', 'MetaProgrammingSystem', 'Nanoc',
                'Nim', 'Node', 'Objective-C', 'OCaml', 'Opa', 'OpenCart', 'OracleForms', 'Packer',
                'Perl', 'Phalcon', 'PlayFramework', 'Plone', 'Prestashop', 'Processing', 'PureScript',
                'Python', 'Qooxdoo', 'Qt', 'R', 'Rails', 'Raku', 'RhodesRhomobile', 'ROS', 'Ruby',
                'Rust', 'Sass', 'Scala', 'Scheme', 'SCons', 'Scrivener', 'Sdcc', 'SeamGen', 'SketchUp',
                'Smalltalk', 'Stella', 'SugarCRM', 'Swift', 'Symfony', 'SymphonyCMS', 'Terraform',
                'TeX', 'Textpattern', 'TurboGears2', 'Typo3', 'Umbraco', 'Unity', 'UnrealEngine',
                'VisualStudio', 'VVVV', 'Waf', 'WordPress', 'Xojo', 'Yeoman', 'Yii', 'ZendFramework',
                'Zephir')


            if ($Remaining.ToLower() -in @("cpp", "c++")) {
                try {                    
                    Start-BitsTransfer -Source "$gitignoreSource/C%2B%2B.gitignore" -Destination ".gitignore"
                    Write-Output "✔️ .gitignore added for $gitignoreCap project"
                }
                catch {
                    Write-Error "❌ Unable to fetch"
                }
            }
            elseif ($Remaining.ToLower() -in @("c#", "csharp", "visualstudio")) {
                try {
                    Start-BitsTransfer -Source "$gitignoreSource/VisualStudio.gitignore" -Destination ".gitignore"
                    Write-Output "✔️ .gitignore added for $gitignoreCap project"
                }
                catch {
                    Write-Error "❌ Unable to fetch"
                }
            }
            elseif ($Remaining.ToLower() -in $gi_names) {
                try {                    
                    Start-BitsTransfer -Source "$gitignoreSource/$gitignoreCap.gitignore" -Destination ".gitignore"
                    Write-Output "✔️ .gitignore added for $gitignoreCap project"
                }
                catch {
                    Write-Error "❌ Unable to fetch"
                }
            }
            else {
                Write-Error "🚫 gitignore not found for the given name"
                
            }
        }
    }
}

# Export-ModuleMember -Function PSL
Set-Alias -Name PSL gitignore -Value PSL gi