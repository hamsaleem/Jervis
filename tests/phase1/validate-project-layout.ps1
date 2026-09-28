[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$requiredFiles = @(
    'README.md',
    'LICENSE',
    '.gitignore',
    'config\jervis.example.json',
    'docs\phase-1-assessment.md',
    'docs\architecture.md',
    'docs\windows-readiness.md'
)

foreach ($relativePath in $requiredFiles) {
    $fullPath = Join-Path $projectRoot $relativePath
    if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
        throw "Required Phase 1 file is missing: $relativePath"
    }
}

try {
    $exampleConfig = Get-Content -LiteralPath (Join-Path $projectRoot 'config\jervis.example.json') -Raw | ConvertFrom-Json
}
catch {
    throw "The example configuration is not valid JSON: $($_.Exception.Message)"
}

if ($exampleConfig.model.cloud_fallback -ne 'disabled') {
    throw 'Cloud fallback must remain disabled in the checked-in example configuration.'
}

$forbiddenNames = @('credentials.json', '.env', 'jervis.local.json')
$forbiddenFiles = Get-ChildItem -LiteralPath $projectRoot -Recurse -Force -File |
    Where-Object {
        $_.FullName -notmatch '[\\/]\.git[\\/]' -and $_.FullName -notmatch '[\\/]upstream[\\/]' -and $_.Name -in $forbiddenNames
    }

if ($forbiddenFiles) {
    $names = ($forbiddenFiles | ForEach-Object { $_.FullName }) -join ', '
    throw "Local credentials or runtime configuration must not enter the project: $names"
}

Write-Output 'Phase 1 project-layout validation passed.'
