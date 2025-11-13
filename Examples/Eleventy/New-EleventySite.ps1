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

    # Initialize a new npm project
    Write-Host "Initializing npm project..."
    npm init -y

    # Install Eleventy
    Write-Host "Installing Eleventy..."
    npm install @11ty/eleventy --save-dev

    # Create a .eleventy.js configuration file
    Write-Host "Creating .eleventy.js..."
@'
module.exports = function(eleventyConfig) {
  return {
    dir: {
      input: "src",
      output: "dist"
    }
  };
};
'@ | Set-Content -Path ".eleventy.js"

    # Create a src directory
    Write-Host "Creating 'src' directory..."
    New-Item -ItemType Directory -Name "src"
    Wait-Path -Path 'src'

    # Create an index.md file
    Write-Host "Creating 'src/index.md'..."
@'
---
layout: layout.njk
title: My Eleventy Site
---

# Hello, World!
'@ | Set-Content -Path "src/index.md"

    # Create a _includes directory
    Write-Host "Creating 'src/_includes' directory..."
    New-Item -ItemType Directory -Name "src/_includes"
    Wait-Path -Path 'src/_includes'

    # Create a layout.njk file
    Write-Host "Creating 'src/_includes/layout.njk'..."
@'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ title }}</title>
</head>
<body>
  {{ content | safe }}
</body>
</html>
'@ | Set-Content -Path "src/_includes/layout.njk"

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
/node_modules
/dist
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new Eleventy site: $ProjectName"
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

