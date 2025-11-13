---
layout: script
title: New-FlutterApp
---

## Overview

The `New-FlutterApp.ps1` script scaffolds a new Flutter application. It automates the setup of a new project directory by using the `flutter create` command.

This script is designed to streamline the initial phase of Flutter application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `flutter create` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `flutter create <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-FlutterApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-FlutterApp.ps1 -ProjectName "MyNewFlutterApp"
```

Replace `"MyNewFlutterApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Flutter application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-FlutterApp.ps1` script from the following link:

[Download New-FlutterApp.ps1](./scripts/New-FlutterApp.ps1)
