<#
  Execute this script with admin permission
#>

# Configure directory

New-Item -Path "$env:USERPROFILE\Developer" -ItemType Directory

# Set environment variable

$env:XDG_DATA_HOME = "$env:LOCALAPPDATA"
[Environment]::SetEnvironmentVariable('XDG_DATA_HOME', $env:XDG_DATA_HOME, 'User')

$env:XDG_CONFIG_HOME = "$env:APPDATA"
[Environment]::SetEnvironmentVariable('XDG_CONFIG_HOME', $env:XDG_CONFIG_HOME, 'User')

$env:XDG_CACHE_HOME = "$env:LOCALAPPDATA\Temp"
[Environment]::SetEnvironmentVariable('XDG_CACHE_HOME', $env:XDG_CACHE_HOME, 'User')

$env:SCOOP = "$env:XDG_DATA_HOME\Scoop"
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

$env:CARGO_HOME = "$env:XDG_DATA_HOME\cargo"
[Environment]::SetEnvironmentVariable('CARGO_HOME', $env:CARGO_HOME, 'User')

$env:GOPATH = "$env:XDG_DATA_HOME\go"
[Environment]::SetEnvironmentVariable('GOPATH', $env:GOPATH, 'User')

$env:GRADLE_USER_HOME = "$env:XDG_DATA_HOME\gradle"
[Environment]::SetEnvironmentVariable('GRADLE_USER_HOME', $env:GRADLE_USER_HOME, 'User')

$env:RUSTUP_HOME = "$env:XDG_DATA_HOME\rustup"
[Environment]::SetEnvironmentVariable('RUSTUP_HOME', $env:RUSTUP_HOME, 'User')

$env:RUSTUP_DIST_SERVER = 'https://rsproxy.cn'
[Environment]::SetEnvironmentVariable('RUSTUP_DIST_SERVER', $env:RUSTUP_DIST_SERVER, 'User')

$env:RUSTUP_UPDATE_ROOT = 'https://rsproxy.cn/rustup'
[Environment]::SetEnvironmentVariable('RUSTUP_UPDATE_ROOT', $env:RUSTUP_UPDATE_ROOT, 'User')

$env:K9SCONFIG = "$env:XDG_CONFIG_HOME\k9s"
[Environment]::SetEnvironmentVariable('K9SCONFIG', $env:K9SCONFIG, 'User')

$env:COURSIER_CACHE = "$env:XDG_DATA_HOME\Coursier\Cache\v1"
[Environment]::SetEnvironmentVariable('COURSIER_CACHE', $env:COURSIER_CACHE, 'User')

$env:SCOOP_GLOBAL = "$env:ProgramData\Scoop"
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

$env:GOPROXY = 'https://goproxy.cn'
[Environment]::SetEnvironmentVariable('GOPROXY', $env:GOPROXY, 'Machine')

$env:HOSTS = 'C:\Windows\System32\drivers\etc\hosts'
[Environment]::SetEnvironmentVariable('HOSTS', $env:HOSTS, 'Machine')

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
    clangd `
    cmake `
    curl `
    delta `
    fzf `
    gcc `
    gdb `
    git `
    gitui `
    go `
    gopass `
    gping `
    gradle `
    gzip `
    hexyl `
    hurl `
    hyperfine `
    llvm `
    miniserve `
    neofetch `
    neovim `
    ninja `
    onefetch `
    procs `
    ripgrep `
    sbt `
    scala `
    starship `
    tar `
    unzip `
    zip `
    zoxide `
    zulufx8-jdk

scoop install `
    FiraCode-NF `
    JetBrainsMono-NF `
    sudo

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
nvim +PlugInstall +qall

Invoke-WebRequest https://win.rustup.rs/x86_64 -OutFile "$env:Temp\rustup.exe"
& "$env:Temp\rustup.exe" '--default-toolchain nightly-x86_64-pc-windows-gnu --profile default --no-modify-path -y --component llvm-tools-preview clippy rust-analyzer-preview rust-src' | Out-Null
