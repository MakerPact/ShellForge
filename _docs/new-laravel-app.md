---
layout: script
title: New-LaravelApp
---

## Overview

The `New-LaravelApp.ps1` script scaffolds a new Laravel application. It automates the setup of a new project directory by using the `composer create-project laravel/laravel` command.

This script is designed to streamline the initial phase of Laravel application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `composer create-project laravel/laravel` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `composer create-project laravel/laravel <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-LaravelApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-LaravelApp.ps1 -ProjectName "MyNewLaravelApp"
```

Replace `"MyNewLaravelApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Laravel application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-LaravelApp.ps1` script from the following link:

[Download New-LaravelApp.ps1](./scripts/New-LaravelApp.ps1)
