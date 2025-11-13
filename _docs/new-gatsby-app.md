---
layout: script
title: New-GatsbyApp
---

## Overview

The `New-GatsbyApp.ps1` script scaffolds a new Gatsby application. It automates the setup of a new project directory by using the Gatsby CLI.

This script is designed to streamline the initial phase of Gatsby application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official Gatsby CLI.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx gatsby new <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-GatsbyApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-GatsbyApp.ps1 -ProjectName "MyNewGatsbyApp"
```

Replace `"MyNewGatsbyApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Gatsby application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-GatsbyApp.ps1` script from the following link:

[Download New-GatsbyApp.ps1](./scripts/New-GatsbyApp.ps1)
