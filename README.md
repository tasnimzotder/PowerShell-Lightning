# Powershell-Lightning ⚡
![PowerShell Gallery Version (including pre-releases)](https://img.shields.io/powershellgallery/v/PowerShell-Lightning?include_prereleases)
.
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/tasnimzotder/PowerShell-Lightning?include_prereleases)
.
![GitHub issues](https://img.shields.io/github/issues/tasnimzotder/PowerShell-Lightning)
.
![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PowerShell-Lightning?label=downloads%20-%20ps%20gallery)
.
![GitHub All Releases](https://img.shields.io/github/downloads/tasnimzotder/PowerShell-Lightning/total?label=downloads%20-%20github)
.





# Prerequisites

## Check for the execution policy

Open PowerShell as Administrator

- Run `Get-ExecutionPolicy`

- If you don't get `RemoteSigned`. Then run `Set-ExecutionPolicy RemoteSigned`

## Terminal Check

You should use Windows Terminal to have a brilliant terminal experience on Windows.

Windows Terminal can be acquired from the Microsoft Store, the [Windows Terminal](https://aka.ms/terminal)

You need to have the new PowerShell, can be downloaded from [here](https://github.com/PowerShell/PowerShell/releases/tag/v7.0.2)


# Installation

## One Line Command (Method 1)

```PowerShell
Install-Module -Name PowerShell-Lightning
```

## Manual (Method 2)

Go to [Releases](https://github.com/tasnimzotder/PowerShell-Lightning/releases) and download from the Assets

Download the source file and extract

You can download from the [Releases](https://github.com/tasnimzotder/PowerShell-Lightning/releases)

- To install - run `Setup.ps1` or `Setup.exe`

## Optional

> - Open `profile.ps1` located in `\\Documents\PowerShell`
or simple run the command `code $PROFILE.CurrentUserAllHosts` or `notepad $PROFILE.CurrentUserAllHosts`

> - add `Import-Module PowerShell-Lightning` to the end

Now Run 
```PowerShell
Get-Module
````
You will see `PowerShell-Lightning` there.

restart the PowerShell

# Functions

| Name          | Alias   | Description                                    |
| --------------| ------- | ---------------------------------------------- |
| `Run_AnyCode` | `makk`  | To run any code eg `makk hello.cpp`            |
| `touch`       | `touch` | Create new file eg `touch hello.txt`           |
| `nano`        | `nano`  | edit files eg `nano hello.txt`                 |
| `rnn`         | `rnn`   | Rename eg `rnn hello.txt` then   `changed.txt` |


# About PowerShell Profile

| Description                | Name                              |
| -------------------------- | --------------------------------- |
| All Users, All Hosts       | `$PROFILE.AllUsersAllHosts`       | 
| All Users, Current Host    | `$PROFILE.AllUsersCurrentHost`    |
| Current User, All Host     | `$PROFILE.CurrentUserAllHosts`    |
| Current User, Current Host | `$PROFILE.CurrentUserCurrentHost` |



.

| Description                | Path                                                             |
| -------------------------- | ---------------------------------------------------------------- |
| All Users, All Hosts       | $PSHOME\Profile.ps1                                              | 
| All Users, Current Host    | $PSHOME\Microsoft.PowerShell_profile.ps1                         |
| Current User, All Host     | $Home\[My ]Documents\PowerShell\Profile.ps1                      |
| Current User, Current Host | $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1 |

