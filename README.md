# Powershell Lightning ⚡

🎉 Smart Powershell CLI Tool for developers - Also Easily Add `.gitignore` file

<p align="center">
    <a href="https://www.powershellgallery.com/packages/PowerShell-Lightning/"><img alt="PowerShell Gallery Version (including pre-releases)" src="https://img.shields.io/powershellgallery/v/PowerShell-Lightning?include_prereleases&logo=powershell&style=flat-square"></a>
    <a><img alt="GitHub release (latest SemVer including pre-releases)" src="https://img.shields.io/github/v/release/tasnimzotder/powershell-lightning?include_prereleases&logo=github&style=flat-square"></a>
    <a><img alt="GitHub issues" src="https://img.shields.io/github/issues/tasnimzotder/powershell-lightning?style=flat-square"></a>
    <a><img alt="PowerShell Gallery" src="https://img.shields.io/powershellgallery/dt/powershell-lightning?logo=powershell&style=flat-square"></a>
    <a><img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/tasnimzotder/powershell-lightning/total?logo=github&style=flat-square"></a>
</p>

## Prerequisites

### Check for the execution policy

Open PowerShell as Administrator

- Run `Get-ExecutionPolicy`

- If you don't get `RemoteSigned`. Then run `Set-ExecutionPolicy RemoteSigned`

### Terminal Check

You should use Windows Terminal to have a brilliant terminal experience on Windows.

Windows Terminal can be acquired from the Microsoft Store, the [Windows Terminal](https://aka.ms/terminal)

You need to have the new PowerShell, can be downloaded from [here](https://github.com/PowerShell/PowerShell/releases/tag/v7.0.2)

## Installation

### One Line Command (Method 1)

```PowerShell
Install-Module -Name PowerShell-Lightning
```

### Manual (Method 2)

1. Go to [Releases](https://github.com/tasnimzotder/PowerShell-Lightning/releases) and download from the Assets

2. Download `exe` file and install

### Optional

> - Open `profile.ps1` located in `\\Documents\PowerShell`
>   or simple run the command `code $PROFILE.CurrentUserAllHosts` or `notepad $PROFILE.CurrentUserAllHosts`

> - add `Import-Module PowerShell-Lightning` to the end

Now Run

```PowerShell
Get-Module
```

You will see `PowerShell-Lightning` there.

restart the PowerShell

For more help write

```PowerShell
PSL info
```

## Arguments

| Name              | Description                    | Example                                  |
| ----------------- | ------------------------------ | ---------------------------------------- |
| `info`            | To display the docs            | `PSL info`                               |
| `doctor`          | To check language setup status | `PSL doctor` or `PSL doctor makk python` |
| `create`          | To create a new project        | `PSL create hello_js node`               |
| `gi`, `gitignore` | To add `.gitignore` file       | `PSL gi node`                            |

## Functions

| Name          | Alias   | Description                                    |
| ------------- | ------- | ---------------------------------------------- |
| `Run_AnyCode` | `makk`  | To run any code <br> `makk hello.cpp`          |
| `touch`       | `touch` | Create new file <br> `touch hello.txt`         |
| `nano`        | `nano`  | edit files <br> `nano hello.txt`               |
| `rnn`         | `rnn`   | Rename <br> `rnn hello.txt` then `changed.txt` |

## Flags

### `Run_AnyCode` or `makk`

| Name            | Description          | Example            |
| --------------- | -------------------- | ------------------ |
| `s`, `silent`   | Run proram silently  | `makk hello.js -s` |
| `p`, `progress` | Show progress status | `makk hello.js -p` |

## About PowerShell Profile

| Description                | Name                              |
| -------------------------- | --------------------------------- |
| All Users, All Hosts       | `$PROFILE.AllUsersAllHosts`       |
| All Users, Current Host    | `$PROFILE.AllUsersCurrentHost`    |
| Current User, All Host     | `$PROFILE.CurrentUserAllHosts`    |
| Current User, Current Host | `$PROFILE.CurrentUserCurrentHost` |

<!-- | Description                | Path                                                             |
| -------------------------- | ---------------------------------------------------------------- |
| All Users, All Hosts       | $PSHOME\Profile.ps1                                              |
| All Users, Current Host    | $PSHOME\Microsoft.PowerShell_profile.ps1                         |
| Current User, All Host     | $Home\[My ]Documents\PowerShell\Profile.ps1                      |
| Current User, Current Host | $Home\[My ]Documents\PowerShell\Microsoft.PowerShell_profile.ps1 | -->
