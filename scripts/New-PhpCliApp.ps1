param (
    [string]$ProjectName
)

$OriginalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

function Wait-Path {
    param(
        [string]$Path,
        [int]$MaxRetries = 50,
        [int]$RetryIntervalMs = 100
    )
    $retryCount = 0
    while (-not (Test-Path -Path $Path) -and $retryCount -lt $MaxRetries) {
        Start-Sleep -Milliseconds $RetryIntervalMs
        $retryCount++
    }
    if (-not (Test-Path -Path $Path)) {
        throw "Failed to find path '$Path' after $MaxRetries retries."
    }
}

try {
    # If ProjectName is not provided, use the current folder's name
    if ([string]::IsNullOrEmpty($ProjectName)) {
        $ProjectName = (Get-Item -Path ".").Name
    }

    # Create the project directory
    Write-Host "Creating project directory: $ProjectName..."
    New-Item -ItemType Directory -Name $ProjectName
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create composer.json
    Write-Host "Creating composer.json..."
@'
{
    "name": "vendor/$ProjectName",
    "description": "A simple PHP CLI application.",
    "type": "project",
    "license": "MIT",
    "autoload": {
        "psr-4": {
            "App\\": "src/"
        }
    },
    "require": {}
}
'@ | Set-Content -Path "composer.json"

    # Create src directory
    Write-Host "Creating 'src' directory..."
    New-Item -ItemType Directory -Name "src"
    Wait-Path -Path 'src'

    # Create src/cli.php
    Write-Host "Creating 'src/cli.php'..."
@'
<?php

namespace App;

require_once __DIR__ . '/../vendor/autoload.php';

class CliApp
{
    public function run()
    {
        echo "Hello from PHP CLI App!\n";
    }
}

$app = new CliApp();
$app->run();
'@ | Set-Content -Path "src/cli.php"

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
/vendor
composer.lock
.env
.env.*
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new PHP CLI App: $ProjectName"
    Write-Host "Run 'php src/cli.php' to execute the application."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

