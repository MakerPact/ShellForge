---
layout: script
title: New-AspNetCoreApi
---

## Overview

The `New-AspNetCoreApi.ps1` script scaffolds a new ASP.NET Core Web API. It automates the setup of a new project directory by using the `dotnet new webapi` command.

This script is designed to streamline the initial phase of ASP.NET Core Web API development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `dotnet new webapi` command.
-   **Project Name:** It prompts the user for the API name (or use the current folder name).
-   **Execution:** Execute `dotnet new webapi -n <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-AspNetCoreApi.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-AspNetCoreApi.ps1 -ProjectName "MyNewApi"
```

Replace `"MyNewApi"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the ASP.NET Core Web API project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-AspNetCoreApi.ps1` script from the following link:

[Download New-AspNetCoreApi.ps1](./scripts/New-AspNetCoreApi.ps1)
