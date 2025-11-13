---
layout: script
title: New-ArduinoProject
---

## Overview

The `New-ArduinoProject.ps1` script scaffolds a new Arduino project with a custom debug print library. It automates the setup of a new project directory, including a Git repository, a main `.ino` file, a custom `DPrint` library, and dedicated folders for documentation, datasheets, and images.

This script is designed to streamline the initial phase of Arduino development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Custom Debug Library:** Includes a custom `DPrint` library that allows for conditional serial printing, making it easy to enable or disable debug messages.
-   **Conventional Folder Structure:** Creates a conventional folder structure with dedicated directories for source code (`src`), libraries (`lib`), documentation (`documentation`), datasheets (`project_datasheets`), and images (`images`).
-   **Boilerplate Code:** Generates a main `.ino` file with boilerplate code, including the setup for the custom `DPrint` library.
-   **.gitignore:** Creates a `.gitignore` file with common entries for Arduino and IDE-specific files.
-   **README.md:** Generates a basic `README.md` file with information about the project structure and how to get started.

## Usage

To use the `New-ArduinoProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-ArduinoProject.ps1 -ProjectName "MyNewArduinoProject"
```

Replace `"MyNewArduinoProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Arduino project. This will also be the name of the project's root directory.
-   `EnableDebugPrint` (Optional): A boolean value that enables or disables the custom debug print feature. It defaults to `$true`.

## How to Download

You can download the `New-ArduinoProject.ps1` script from the following link:

[Download New-ArduinoProject.ps1](./scripts/New-ArduinoProject.ps1)
