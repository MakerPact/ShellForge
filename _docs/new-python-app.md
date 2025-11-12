---
layout: script
title: New-PythonApp
---

## Overview

The `New-PythonApp.ps1` script scaffolds a new Python application. It automates the setup of a new project directory, including a Git repository, a `main.py` file, a `requirements.txt` file, and a virtual environment.

This script is designed to streamline the initial phase of Python application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Boilerplate Code:** Creates a `main.py` file with a simple `if __name__ == "__main__":` block.
-   **Requirements File:** Creates a `requirements.txt` file for managing dependencies.
-   **Virtual Environment:** Creates a virtual environment folder (e.g., `.venv`).
-   **.gitignore:** Creates a `.gitignore` file that ignores the virtual environment folder and `__pycache__`.

## Usage

To use the `New-PythonApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-PythonApp.ps1 -ProjectName "MyNewPythonApp"
```

Replace `"MyNewPythonApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Python application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-PythonApp.ps1` script from the following link:

[Download New-PythonApp.ps1](./scripts/New-PythonApp.ps1)
