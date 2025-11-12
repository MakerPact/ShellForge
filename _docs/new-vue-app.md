---
layout: script
title: New-VueApp
---

## Overview

The `New-VueApp.ps1` script scaffolds a new Vue.js application. It automates the setup of a new project directory by using the `create-vite` tool with the Vue template.

This script is designed to streamline the initial phase of Vue.js application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official `create-vite` tool.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx create-vite . --template vue`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-VueApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-VueApp.ps1 -ProjectName "MyNewVueApp"
```

Replace `"MyNewVueApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Vue.js application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-VueApp.ps1` script from the following link:

[Download New-VueApp.ps1](./scripts/New-VueApp.ps1)
