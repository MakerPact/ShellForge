param (
    [string]$ProjectName
)

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
}

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

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
