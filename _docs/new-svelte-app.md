---
layout: script
title: New-SvelteApp
---

## Overview

The `New-SvelteApp.ps1` script scaffolds a new Svelte application. It automates the setup of a new project directory by using the `create-vite` tool with the Svelte template.

This script is designed to streamline the initial phase of Svelte application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official `create-vite` tool.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx create-vite . --template svelte`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-SvelteApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-SvelteApp.ps1 -ProjectName "MyNewSvelteApp"
```

Replace `"MyNewSvelteApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Svelte application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-SvelteApp.ps1` script from the following link:

[Download New-SvelteApp.ps1](./scripts/New-SvelteApp.ps1)
