---
layout: script
title: New-RailsApp
---

## Overview

The `New-RailsApp.ps1` script scaffolds a new Ruby on Rails application. It automates the setup of a new project directory by using the `rails new` command.

This script is designed to streamline the initial phase of Ruby on Rails application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `rails new` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `rails new <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-RailsApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-RailsApp.ps1 -ProjectName "MyNewRailsApp"
```

Replace `"MyNewRailsApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Ruby on Rails application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-RailsApp.ps1` script from the following link:

[Download New-RailsApp.ps1](./scripts/New-RailsApp.ps1)
