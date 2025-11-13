---
layout: script
title: New-AngularApp
---

## Overview

The `New-AngularApp.ps1` script scaffolds a new Angular application. It automates the setup of a new project directory by using the Angular CLI.

This script is designed to streamline the initial phase of Angular application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official Angular CLI.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx @angular/cli new <ProjectName> --defaults`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-AngularApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-AngularApp.ps1 -ProjectName "MyNewAngularApp"
```

Replace `"MyNewAngularApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Angular application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-AngularApp.ps1` script from the following link:

[Download New-AngularApp.ps1](./scripts/New-AngularApp.ps1)
