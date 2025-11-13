---
layout: script
title: New-PhpCliApp
---

## Overview

The `New-PhpCliApp.ps1` script scaffolds a new PHP CLI application. It automates the setup of a new project directory, including a Git repository, a `composer.json` file, and a basic `src/cli.php` entry point.

This script is designed to streamline the initial phase of PHP CLI application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Composer Configuration:** Creates a `composer.json` file for dependency management.
-   **Boilerplate Code:** Creates a `src` directory with a `cli.php` file containing a simple "Hello from PHP CLI App!" message.
-   **.gitignore:** Creates a `.gitignore` file with common PHP and Composer-specific entries.

## Usage

To use the `New-PhpCliApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-PhpCliApp.ps1 -ProjectName "MyNewPhpCliApp"
```

Replace `"MyNewPhpCliApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the PHP CLI application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-PhpCliApp.ps1` script from the following link:

[Download New-PhpCliApp.ps1](./scripts/New-PhpCliApp.ps1)
