$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$destination = $env:CARD_BOARD_PLUGIN_DIR

if ([string]::IsNullOrWhiteSpace($destination)) {
    $destination = "C:\Users\felipe\Documents\Obsidian\obsidian\Cortex\Cortex\.obsidian\plugins\card-board-enhanced"
}

$requiredFiles = @("manifest.json", "main.js", "styles.css")

foreach ($file in $requiredFiles) {
    $source = Join-Path $repoRoot $file
    if (-not (Test-Path $source)) {
        throw "Missing required plugin file: $source. Run npm run build first."
    }
}

New-Item -ItemType Directory -Force $destination | Out-Null

foreach ($file in $requiredFiles) {
    Copy-Item -LiteralPath (Join-Path $repoRoot $file) -Destination $destination -Force
}

Write-Host "Deployed CardBoard Enhanced to $destination"
