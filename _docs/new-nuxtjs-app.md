---
layout: script
title: New-NuxtJsApp
---

## Overview

The `New-NuxtJsApp.ps1` script scaffolds a new Nuxt.js application. It automates the setup of a new project directory by using `create-nuxt-app`.

This script is designed to streamline the initial phase of Nuxt.js application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around `create-nuxt-app`.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx create-nuxt-app <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-NuxtJsApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-NuxtJsApp.ps1 -ProjectName "MyNewNuxtJsApp"
```

Replace `"MyNewNuxtJsApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Nuxt.js application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-NuxtJsApp.ps1` script from the following link:

[Download New-NuxtJsApp.ps1](./scripts/New-NuxtJsApp.ps1)
