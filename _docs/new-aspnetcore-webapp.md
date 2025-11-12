---
layout: script
title: New-AspNetCoreWebApp
---

## Overview

The `New-AspNetCoreWebApp.ps1` script scaffolds a new ASP.NET Core Web Application. It automates the setup of a new project directory by using the `dotnet new webapp` command.

This script is designed to streamline the initial phase of ASP.NET Core Web App development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `dotnet new webapp` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `dotnet new webapp -n <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-AspNetCoreWebApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-AspNetCoreWebApp.ps1 -ProjectName "MyNewWebApp"
```

Replace `"MyNewWebApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the ASP.NET Core Web Application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-AspNetCoreWebApp.ps1` script from the following link:

[Download New-AspNetCoreWebApp.ps1](./scripts/New-AspNetCoreWebApp.ps1)
