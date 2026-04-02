$profilePath = $PROFILE.CurrentUserCurrentHost

if (-not (Test-Path $profilePath)) {
    Write-Host "Profile not found: $profilePath"
    exit 0
}

$content = Get-Content $profilePath -Raw
$updated = $content -replace '(?m)^\s*&\s*"[^"]*MatrixRain\.ps1"\s*$', '# & "C:\Scripts\MatrixRain.ps1"'

if ($updated -eq $content) {
    Write-Host "No active MatrixRain profile line found."
    exit 0
}

Set-Content -Path $profilePath -Value $updated -Encoding UTF8
Write-Host "Disabled MatrixRain launch in: $profilePath"
