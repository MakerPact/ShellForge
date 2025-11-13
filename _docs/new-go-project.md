---
layout: script
title: New-GoProject
---

## Overview

The `New-GoProject.ps1` script scaffolds a new Go project. It automates the setup of a new project directory, including a Git repository, a `main.go` file, and a `go.mod` file.

This script is designed to streamline the initial phase of Go project development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Boilerplate Code:** Creates a `main.go` file with a simple "Hello, World!" program.
-   **Go Modules:** Initializes a new Go module with `go mod init`.
-   **.gitignore:** Creates a `.gitignore` file with common entries for Go projects.

## Usage

To use the `New-GoProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-GoProject.ps1 -ProjectName "MyNewGoProject"
```

Replace `"MyNewGoProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Go project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-GoProject.ps1` script from the following link:

[Download New-GoProject.ps1](./scripts/New-GoProject.ps1)
