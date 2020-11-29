# Powershell Lightning ⚡

🎉 Smart Powershell CLI Tool for developers - Also Easily Add `.gitignore` file

<p align="center">
    <a href="https://www.powershellgallery.com/packages/PowerShell-Lightning/"><img alt="PowerShell Gallery Version (including pre-releases)" src="https://img.shields.io/powershellgallery/v/PowerShell-Lightning?include_prereleases&logo=powershell&style=flat-square"></a>
    <a><img alt="GitHub release (latest SemVer including pre-releases)" src="https://img.shields.io/github/v/release/tasnimzotder/powershell-lightning?include_prereleases&logo=github&style=flat-square"></a>
    <a><img alt="GitHub issues" src="https://img.shields.io/github/issues/tasnimzotder/powershell-lightning?style=flat-square"></a>
    <a><img alt="PowerShell Gallery" src="https://img.shields.io/powershellgallery/dt/powershell-lightning?logo=powershell&style=flat-square"></a>
    <a><img alt="GitHub All Releases" src="https://img.shields.io/github/downloads/tasnimzotder/powershell-lightning/total?logo=github&style=flat-square"></a>
</p>

## ⚓ Prerequisites

### Check for the execution policy

Open PowerShell as Administrator

- Run `Get-ExecutionPolicy`

- If you don't get `RemoteSigned`. Then run `Set-ExecutionPolicy RemoteSigned`

### Terminal Check

You should use Windows Terminal to have a brilliant terminal experience on Windows.

Windows Terminal can be acquired from the Microsoft Store, the [Windows Terminal](https://aka.ms/terminal)

You need to have the new PowerShell, can be downloaded from [here](https://github.com/PowerShell/PowerShell/releases/tag/v7.0.2)

## 💻 Installation

### One Line Command (Method 1)

```PowerShell
Install-Module -Name PowerShell-Lightning
```

### Manual (Method 2)

1. Go to [Releases](https://github.com/tasnimzotder/PowerShell-Lightning/releases) and download from the Assets

2. Download the `exe` file and install

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

## 🔗 Arguments

| Name              | Description                    | Example                                  |
| ----------------- | ------------------------------ | ---------------------------------------- |
| `info`            | Display the docs            | `psl info`                               |
| `doctor`          | Check language setup status | `psl doctor` |
| `c`, `create`     | Create a new project        | `psl create hello_js node`               |
| `s`, `setup`      | Setup project env / config     | `psl setup`                              |
| `gi`, `gitignore` | Add `.gitignore` file       | `psl gi node`                            |

## 🛠 Functions

| Name          | Alias   | Description                                    |
| ------------- | ------- | ---------------------------------------------- |
| `Run_AnyCode` | `makk`  | Run code <br> `makk hello.cpp`          |
| `touch`       | `touch` | Create new file <br> `touch hello.txt`         |
| `nano`        | `nano`  | Edit file <br> `nano hello.txt`               |
| `rnn`         | `rnn`   | Rename file <br> `rnn hello.txt` then `changed.txt` |

## 🚩 Flags

### `Run_AnyCode` or `makk`

| Name            | Description          | Example            |
| --------------- | -------------------- | ------------------ |
| `s`, `silent`   | Run proram silently  | `makk hello.js -s` |
| `p`, `progress` | Show progress status | `makk hello.js -p` |

## 🆎 About PowerShell Profile

| Description                | Name                              |
| -------------------------- | --------------------------------- |
| All Users, All Hosts       | `$PROFILE.AllUsersAllHosts`       |
| All Users, Current Host    | `$PROFILE.AllUsersCurrentHost`    |
| Current User, All Host     | `$PROFILE.CurrentUserAllHosts`    |
| Current User, Current Host | `$PROFILE.CurrentUserCurrentHost` |
