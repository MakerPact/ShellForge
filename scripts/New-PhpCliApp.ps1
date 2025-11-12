param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

# Wait for the directory to exist
$maxRetries = 50
$retryCount = 0
while (-not (Test-Path -Path $ProjectName) -and $retryCount -lt $maxRetries) {
    Start-Sleep -Milliseconds 100
    $retryCount++
}
if (-not (Test-Path -Path $ProjectName)) {
    throw "Failed to create project directory '$ProjectName' after multiple retries."
}

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# Create composer.json
@'
{
    "name": "vendor/$ProjectName",
    "description": "A simple PHP CLI application.",
    "type": "project",
    "license": "MIT",
    "autoload": {
        "psr-4": {
            "App\": "src/"
        }
    },
    "require": {}
}
'@ | Set-Content -Path "composer.json"

# Create src directory
New-Item -ItemType Directory -Name "src"

# Wait for the directory to exist
$maxRetries = 50
$retryCount = 0
while (-not (Test-Path -Path 'src') -and $retryCount -lt $maxRetries) {
    Start-Sleep -Milliseconds 100
    $retryCount++
}
if (-not (Test-Path -Path 'src')) {
    throw "Failed to create 'src' directory after multiple retries."
}

# Create src/cli.php
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
@'
/vendor
composer.lock
.env
.env.*
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new PHP CLI App: $ProjectName"
Write-Host "Run 'php src/cli.php' to execute the application."
