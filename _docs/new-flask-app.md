---
layout: script
title: New-FlaskApp
---

## Overview

The `New-FlaskApp.ps1` script scaffolds a new Flask application. It automates the setup of a new project directory, including a Git repository, a Python virtual environment, a basic `app.py` file, and a `requirements.txt`.

This script is designed to streamline the initial phase of Flask application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Virtual Environment:** Creates a Python virtual environment and installs Flask within it.
-   **Boilerplate Code:** Creates an `app.py` file with a simple "Hello, World!" Flask application.
-   **Requirements File:** Creates a `requirements.txt` file listing Flask as a dependency.
-   **.gitignore:** Creates a `.gitignore` file with common Python-specific entries.

## Usage

To use the `New-FlaskApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-FlaskApp.ps1 -ProjectName "MyNewFlaskApp"
```

Replace `"MyNewFlaskApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Flask application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-FlaskApp.ps1` script from the following link:

[Download New-FlaskApp.ps1](./scripts/New-FlaskApp.ps1)
