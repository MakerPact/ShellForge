---
layout: script
title: New-ReactApp
---

## Overview

The `New-ReactApp.ps1` script scaffolds a new React frontend application. It automates the setup of a new project directory by using the `create-react-app` or `Vite` tool.

This script is designed to streamline the initial phase of React application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official `create-react-app` or `Vite` tool.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx create-react-app .` or `npx create-vite . --template react`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-ReactApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-ReactApp.ps1 -ProjectName "MyNewReactApp"
```

Replace `"MyNewReactApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the React application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-ReactApp.ps1` script from the following link:

[Download New-ReactApp.ps1](./scripts/New-ReactApp.ps1)
