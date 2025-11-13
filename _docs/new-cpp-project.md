---
layout: script
title: New-CppProject
---

## Overview

The `New-CppProject.ps1` script scaffolds a new C++ project. It automates the setup of a new project directory, including a Git repository, a `src` directory with a `main.cpp` file, and a `Makefile`.

This script is designed to streamline the initial phase of C++ project development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Boilerplate Code:** Creates a `main.cpp` file with a simple "Hello, World!" program.
-   **Makefile:** Creates a basic `Makefile` for compiling the project.
-   **Conventional Folder Structure:** Creates a `src` directory for source code.
-   **.gitignore:** Creates a `.gitignore` file that ignores compiled object files and the executable.

## Usage

To use the `New-CppProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-CppProject.ps1 -ProjectName "MyNewCppProject"
```

Replace `"MyNewCppProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the C++ project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-CppProject.ps1` script from the following link:

[Download New-CppProject.ps1](./scripts/New-CppProject.ps1)
