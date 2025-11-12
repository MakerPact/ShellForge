---
layout: script
title: New-PowerShellScript
---

## Overview

The `New-PowerShellScript.ps1` script scaffolds a new PowerShell script project. It automates the setup of a new project directory, including a Git repository, a module file, a manifest file, and a test file.

This script is designed to streamline the initial phase of PowerShell script development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Module and Manifest:** Creates a `<ProjectName>.psm1` module file and a `<ProjectName>.psd1` manifest file.
-   **Pester Tests:** Creates a `tests` folder with a `<ProjectName>.Tests.ps1` file using Pester for testing.
-   **.gitignore:** Creates a `.gitignore` file with common entries for PowerShell projects.

## Usage

To use the `New-PowerShellScript.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-PowerShellScript.ps1 -ProjectName "MyNewPowerShellScript"
```

Replace `"MyNewPowerShellScript"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the PowerShell script project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-PowerShellScript.ps1` script from the following link:

[Download New-PowerShellScript.ps1](./scripts/New-PowerShellScript.ps1)
