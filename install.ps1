<#
  Execute this script with admin permission
#>

# Configure directory

New-Item -Path "$env:USERPROFILE\Developer" -ItemType Directory

# Set environment variable

$env:SCOOP = '%AppData%\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

$env:SCOOP_GLOBAL = '%ProgramData%\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

$env:CARGO_HOME = '%AppData%\cargo'
[Environment]::SetEnvironmentVariable('CARGO_HOME', $env:CARGO_HOME, 'User')

$env:RUSTUP_HOME = '%AppData%\rustup'
[Environment]::SetEnvironmentVariable('RUSTUP_HOME', $env:RUSTUP_HOME, 'User')

# Install packages

Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts

scoop install -g `
    7zip `
    aria2 `
    bottom `
    curl `
    delta `
    fzf `
    gcc `
    git `
    gitui `
    go `
    gopass `
    gping `
    gradle `
    hexyl `
    miniserve `
    neofetch `
    neovim `
    onefetch `
    procs `
    ripgrep `
    sbt `
    scala `
    starship `
    sudo `
    zoxide `
    zulufx8-jdk

scoop install `
    FiraCode-NF `
    JetBrainsMono-NF

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
nvim +PlugInstall +qall

Invoke-WebRequest https://win.rustup.rs/x86_64 -OutFile "$env:Temp\rustup.exe"
& "$env:Temp\rustup.exe" '--default-toolchain nightly --default-toolchain nightly-x86_64-pc-windows-gnu --profile default --no-modify-path -y' | Out-Null
