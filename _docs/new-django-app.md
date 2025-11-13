---
layout: script
title: New-DjangoApp
---

## Overview

The `New-DjangoApp.ps1` script scaffolds a new Django application. It automates the setup of a new project directory, including a Git repository, a Python virtual environment, and a basic Django project structure.

This script is designed to streamline the initial phase of Django application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Virtual Environment:** Creates a Python virtual environment and installs Django within it.
-   **Django Project Setup:** Uses `django-admin startproject` to create the basic Django project files.
-   **.gitignore:** Creates a `.gitignore` file with common Python and Django-specific entries.

## Usage

To use the `New-DjangoApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-DjangoApp.ps1 -ProjectName "MyNewDjangoApp"
```

Replace `"MyNewDjangoApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Django application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-DjangoApp.ps1` script from the following link:

[Download New-DjangoApp.ps1](./scripts/New-DjangoApp.ps1)
