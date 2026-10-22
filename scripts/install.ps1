<#
.SYNOPSIS
    Esprit one-line installer for Windows CMD & PowerShell.
.DESCRIPTION
    Installs the latest release of Esprit for Windows.
    Adds Esprit to the current user's PATH automatically.
.EXAMPLE
    irm https://raw.githubusercontent.com/krtvysinghhhh/Esprit/main/scripts/install.ps1 | iex
#>

[CmdletBinding()]
param(
    [string]$Version = "latest",
    [string]$InstallDir = "$env:USERPROFILE\.esprit\bin"
)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Repo = "krtvysinghhhh/Esprit"

Write-Host ""
Write-Host "  ███████╗███████╗██████╗ ██████╗ ██╗████████╗" -ForegroundColor Cyan
Write-Host "  ██╔════╝██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝" -ForegroundColor Cyan
Write-Host "  █████╗  ███████╗██████╔╝██████╔╝██║   ██║   " -ForegroundColor Cyan
Write-Host "  ██╔══╝  ╚════██║██╔═══╝ ██╔══██╗██║   ██║   " -ForegroundColor Cyan
Write-Host "  ███████╗███████║██║     ██║  ██║██║   ██║   " -ForegroundColor Cyan
Write-Host ""
Write-Host "  Esprit Windows Installer (CMD / PowerShell)" -ForegroundColor DarkGray
Write-Host "  ──────────────────────────────────────────────────────────" -ForegroundColor DarkGray

# Ensure Target Directory Exists
if (-not (Test-Path -Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

$ExeTarget = Join-Path $InstallDir "esprit.exe"

# Resolve latest version
if ($Version -eq "latest") {
    try {
        $ReleaseUrl = "https://api.github.com/repos/$Repo/releases/latest"
        $ReleaseJson = Invoke-RestMethod -Uri $ReleaseUrl -Headers @{ "User-Agent" = "Esprit-Installer" }
        $Version = $ReleaseJson.tag_name.TrimStart('v')
    } catch {
        $Version = "0.1.0"
    }
}

Write-Host "  • Target Version:  v$Version" -ForegroundColor Gray
Write-Host "  • Installation:    $InstallDir" -ForegroundColor Gray

# Try downloading release binary or building via Cargo
$Downloaded = $false
$ZipUrl = "https://github.com/$Repo/releases/download/v$Version/esprit-x86_64-pc-windows-msvc.zip"
$ZipDest = Join-Path $env:TEMP "esprit.zip"

Write-Host "  • Downloading prebuilt binary..." -ForegroundColor Gray
try {
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipDest -UseBasicParsing -TimeoutSec 30
    Expand-Archive -Path $ZipDest -DestinationPath $InstallDir -Force
    Remove-Item $ZipDest -Force -ErrorAction SilentlyContinue
    $Downloaded = $true
} catch {
    Write-Host "  ⚠ Prebuilt binary not ready yet. Checking for Cargo..." -ForegroundColor Yellow
}

if (-not $Downloaded) {
    if (Get-Command cargo -ErrorAction SilentlyContinue) {
        Write-Host "  • Compiling from source with Cargo (high-performance)..." -ForegroundColor Cyan
        cargo install --git "https://github.com/$Repo.git" esprit-cli --root "$env:USERPROFILE\.esprit" --quiet
        $Downloaded = $true
    } else {
        Write-Host "  ✗ Could not install automatically." -ForegroundColor Red
        Write-Host "    Please install Rust via https://rustup.rs or download from:" -ForegroundColor Gray
        Write-Host "    https://github.com/$Repo/releases" -ForegroundColor Gray
        exit 1
    }
}

# Update User PATH if not present
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$InstallDir*") {
    Write-Host "  • Adding $InstallDir to User PATH..." -ForegroundColor Cyan
    $NewPath = "$UserPath;$InstallDir".TrimEnd(';')
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    $env:Path = "$env:Path;$InstallDir"
}

Write-Host ""
Write-Host "  ✓ Esprit v$Version installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "  Quick Start (run in CMD or PowerShell):" -ForegroundColor DarkGray
Write-Host "    esprit doctor             # System & AI diagnostic" -ForegroundColor White
Write-Host "    esprit clean --dry-run    # Preview storage cleanup" -ForegroundColor White
Write-Host "    esprit --help             # Command reference" -ForegroundColor White
Write-Host ""
