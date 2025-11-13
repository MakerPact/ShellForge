---
layout: script
title: New-XamarinApp
---

## Overview

The `New-XamarinApp.ps1` script scaffolds a new Xamarin application. It automates the setup of a new project directory by using the `dotnet new xamarinforms` command.

This script is designed to streamline the initial phase of Xamarin application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `dotnet new xamarinforms` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `dotnet new xamarinforms -n <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-XamarinApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-XamarinApp.ps1 -ProjectName "MyNewXamarinApp"
```

Replace `"MyNewXamarinApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Xamarin application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-XamarinApp.ps1` script from the following link:

[Download New-XamarinApp.ps1](./scripts/New-XamarinApp.ps1)
