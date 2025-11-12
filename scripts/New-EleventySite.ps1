param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

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
