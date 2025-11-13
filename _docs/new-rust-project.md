---
layout: script
title: New-RustProject
---

## Overview

The `New-RustProject.ps1` script scaffolds a new Rust project. It automates the setup of a new project directory by using the `cargo new` command.

This script is designed to streamline the initial phase of Rust project development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official `cargo new` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `cargo new`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-RustProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-RustProject.ps1 -ProjectName "MyNewRustProject"
```

Replace `"MyNewRustProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Rust project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-RustProject.ps1` script from the following link:

[Download New-RustProject.ps1](./scripts/New-RustProject.ps1)
