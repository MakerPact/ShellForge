---
layout: script
title: New-MkDocsSite
---

## Overview

The `New-MkDocsSite.ps1` script scaffolds a new MkDocs static site. It automates the setup of a new project directory, including a Git repository, a Python virtual environment, and a basic MkDocs project structure.

This script is designed to streamline the initial phase of MkDocs site development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Virtual Environment:** Creates a Python virtual environment and installs MkDocs within it.
-   **MkDocs Project Setup:** Uses `mkdocs new` to create the basic MkDocs project files.
-   **.gitignore:** Creates a `.gitignore` file with common Python and MkDocs-specific entries.

## Usage

To use the `New-MkDocsSite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-MkDocsSite.ps1 -ProjectName "MyNewMkDocsSite"
```

Replace `"MyNewMkDocsSite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the MkDocs site project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-MkDocsSite.ps1` script from the following link:

[Download New-MkDocsSite.ps1](./scripts/New-MkDocsSite.ps1)
