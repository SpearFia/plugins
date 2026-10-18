<#
.SYNOPSIS
  Installs Spear Fia plugins on Windows.
  DCTLs  -> C:\ProgramData\Blackmagic Design\DaVinci Resolve\Support\LUT\SpearFia\
  OFX    -> C:\Program Files\Common Files\OFX\Plugins\   (needs an elevated PowerShell)
.EXAMPLE
  .\scripts\install.ps1                      # every plugin
  .\scripts\install.ps1 -Plugin focus-loupe  # one plugin
#>
param([string]$Plugin = "*")
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$dctlDest = "C:\ProgramData\Blackmagic Design\DaVinci Resolve\Support\LUT\SpearFia"
$ofxDest = "C:\Program Files\Common Files\OFX\Plugins"

$dctls = Get-ChildItem -Path (Join-Path $root "$Plugin\dctl") -Filter *.dctl -ErrorAction SilentlyContinue
$bundles = Get-ChildItem -Path (Join-Path $root "$Plugin\ofx") -Filter *.ofx.bundle -Directory -Recurse -ErrorAction SilentlyContinue
if (-not $dctls -and -not $bundles) { throw "Nothing to install for '$Plugin'." }

if ($dctls) {
  New-Item -ItemType Directory -Force $dctlDest | Out-Null
  foreach ($f in $dctls) { Copy-Item $f.FullName $dctlDest -Force; Write-Host "DCTL  $($f.Name) -> $dctlDest" }
  Write-Host "In Resolve: ResolveFX DCTL > DCTL List > SpearFia, then press Reset."
}

if ($bundles) {
  $admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)
  if (-not $admin) { throw "Installing OFX bundles needs an elevated PowerShell (Run as administrator)." }
  New-Item -ItemType Directory -Force $ofxDest | Out-Null
  foreach ($b in $bundles) { Copy-Item $b.FullName $ofxDest -Recurse -Force; Write-Host "OFX   $($b.Name) -> $ofxDest" }
  Write-Host "Restart Resolve to load new OFX plugins."
}
