---
layout: script
title: New-EmberApp
---

## Overview

The `New-EmberApp.ps1` script scaffolds a new Ember.js application. It automates the setup of a new project directory by using the Ember CLI.

This script is designed to streamline the initial phase of Ember.js application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the official Ember CLI.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx ember-cli new <ProjectName> --skip-git`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-EmberApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-EmberApp.ps1 -ProjectName "MyNewEmberApp"
```

Replace `"MyNewEmberApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Ember.js application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-EmberApp.ps1` script from the following link:

[Download New-EmberApp.ps1](./scripts/New-EmberApp.ps1)
