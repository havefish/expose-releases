# Copyright (c) 2026 Chinmaya Panda. All rights reserved.
# Proprietary Software - Developed by Chinmaya Panda
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Bolt = [char]0x26A1
$Check = [char]0x2705

$Repo = "havefish/expose-releases"

Write-Host "$Bolt Installing Expose CLI..." -ForegroundColor Cyan

# Architecture detection
$Arch = "amd64"
if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") {
    $Arch = "arm64"
}

Write-Host "=> Detected Windows ($Arch)"

# Fetch latest release
$ApiUrl = "https://api.github.com/repos/$Repo/releases/latest"
try {
    $Release = Invoke-RestMethod -Uri $ApiUrl
    $Version = $Release.tag_name
}
catch {
    Write-Error "Failed to fetch the latest release tag from GitHub."
    exit 1
}

$FileName = "expose_windows_${Arch}.zip"
$DownloadUrl = "https://github.com/$Repo/releases/download/$Version/$FileName"

$InstallDir = Join-Path $HOME ".expose\bin"
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}

$TempZip = Join-Path $env:TEMP $FileName
$TempExtracted = Join-Path $env:TEMP "expose_extracted"

Write-Host "=> Downloading expose $Version..."
Invoke-WebRequest -Uri $DownloadUrl -OutFile $TempZip

Write-Host "=> Extracting..."
if (Test-Path $TempExtracted) { Remove-Item -Recurse -Force $TempExtracted }
Expand-Archive -Path $TempZip -DestinationPath $TempExtracted -Force

Write-Host "=> Installing to $InstallDir..."
Move-Item -Path (Join-Path $TempExtracted "expose.exe") -Destination (Join-Path $InstallDir "expose.exe") -Force


# Clean up
Remove-Item -Path $TempZip -Force
Remove-Item -Recurse -Force $TempExtracted

# Add to PATH if not already there
$UserPath = [Environment]::GetEnvironmentVariable("PATH", "User")
if ($UserPath -notmatch [regex]::Escape($InstallDir)) {
    Write-Host "=> Adding $InstallDir to user PATH..."
    $NewPath = $UserPath + ";" + $InstallDir
    [Environment]::SetEnvironmentVariable("PATH", $NewPath, "User")
    Write-Host "=> NOTE: You may need to restart your terminal for the PATH changes to take effect." -ForegroundColor Yellow
}

Write-Host "$Check Successfully installed 'expose'." -ForegroundColor Green
Write-Host "Try running 'expose -port 8080' to start tunneling!" -ForegroundColor Gray
