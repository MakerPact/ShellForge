---
layout: script
title: New-CsharpConsoleApp
---

## Overview

The `New-CsharpConsoleApp.ps1` script scaffolds a new C# Console Application. It automates the setup of a new project directory by using the `dotnet new console` command.

This script is designed to streamline the initial phase of C# Console App development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `dotnet new console` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `dotnet new console -n <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-CsharpConsoleApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-CsharpConsoleApp.ps1 -ProjectName "MyNewConsoleApp"
```

Replace `"MyNewConsoleApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the C# Console Application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-CsharpConsoleApp.ps1` script from the following link:

[Download New-CsharpConsoleApp.ps1](./scripts/New-CsharpConsoleApp.ps1)
