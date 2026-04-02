$profilePath = $PROFILE.CurrentUserCurrentHost
$matrixScript = Join-Path $PSScriptRoot "MatrixRain.ps1"
$line = "& `"$matrixScript`""

if (-not (Test-Path $profilePath)) {
    New-Item -Path $profilePath -ItemType File -Force | Out-Null
}

$content = Get-Content $profilePath -ErrorAction SilentlyContinue
if ($content -contains $line) {
    Write-Host "Matrix profile line already present."
    exit 0
}

Add-Content -Path $profilePath -Value $line
Write-Host "Installed Matrix profile line in: $profilePath"
