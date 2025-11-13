---
layout: script
title: New-NextJsApp
---

## Overview

The `New-NextJsApp.ps1` script scaffolds a new Next.js application. It automates the setup of a new project directory by using `create-next-app`.

This script is designed to streamline the initial phase of Next.js application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around `create-next-app`.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx create-next-app <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-NextJsApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-NextJsApp.ps1 -ProjectName "MyNewNextJsApp"
```

Replace `"MyNewNextJsApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Next.js application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-NextJsApp.ps1` script from the following link:

[Download New-NextJsApp.ps1](./scripts/New-NextJsApp.ps1)
