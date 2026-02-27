#requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$SiteRoot = "D:\01_ProjectsMedia\05_WebDev\eryklabs"
$Url = "http://localhost:1313/"

if (-not (Test-Path $SiteRoot)) {
  throw "Site root not found: $SiteRoot"
}

# Sanity check: hugo must be on PATH
if (-not (Get-Command hugo -ErrorAction SilentlyContinue)) {
  throw "Hugo isn't on PATH. Install Hugo and/or add it to PATH, then retry."
}

Set-Location $SiteRoot

# Open browser first (or after a short delay). Default browser:
Start-Process $Url   # opens in default browser :contentReference[oaicite:6]{index=6}

# Start Hugo server with drafts enabled (-D)
hugo server -D       # drafts :contentReference[oaicite:7]{index=7}
