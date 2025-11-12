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

# Initialize a new npm project
npm init -y

# Install Eleventy
npm install @11ty/eleventy --save-dev

# Create a .eleventy.js configuration file
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

# Create an index.md file
@'
---
layout: layout.njk
title: My Eleventy Site
---

# Hello, World!
'@ | Set-Content -Path "src/index.md"

# Create a _includes directory
New-Item -ItemType Directory -Name "src/_includes"
# Wait for the directory to exist
$maxRetries = 50
$retryCount = 0
while (-not (Test-Path -Path 'src/_includes') -and $retryCount -lt $maxRetries) {
    Start-Sleep -Milliseconds 100
    $retryCount++
}
if (-not (Test-Path -Path 'src/_includes')) {
    throw "Failed to create 'src/_includes' directory after multiple retries."
}

# Create a layout.njk file
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
git init

# Create a .gitignore file
@'
/node_modules
/dist
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Eleventy site: $ProjectName"
