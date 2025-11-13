---
layout: script
title: New-ElectronApp
---

## Overview

The `New-ElectronApp.ps1` script scaffolds a new Electron application. It automates the setup of a new project directory, including a Git repository, a basic Electron project structure with `main.js` and `index.html`, and `package.json` configuration.

This script is designed to streamline the initial phase of Electron application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **npm Initialization:** Initializes a new npm project and installs Electron as a development dependency.
-   **Boilerplate Code:** Creates `main.js` and `index.html` with a basic Electron "Hello World" application.
-   **package.json Configuration:** Configures the `start` script and `main` entry point in `package.json`.
-   **.gitignore:** Creates a `.gitignore` file with common Node.js and Electron-specific entries.

## Usage

To use the `New-ElectronApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-ElectronApp.ps1 -ProjectName "MyNewElectronApp"
```

Replace `"MyNewElectronApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Electron application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-ElectronApp.ps1` script from the following link:

[Download New-ElectronApp.ps1](./scripts/New-ElectronApp.ps1)
