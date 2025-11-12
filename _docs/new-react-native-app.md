---
layout: script
title: New-ReactNativeApp
---

## Overview

The `New-ReactNativeApp.ps1` script scaffolds a new React Native application. It automates the setup of a new project directory by using the `npx react-native init` command.

This script is designed to streamline the initial phase of React Native application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `npx react-native init` command.
-   **Project Name:** It prompts the user for the app name (or use the current folder name).
-   **Execution:** Execute `npx react-native init <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-ReactNativeApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-ReactNativeApp.ps1 -ProjectName "MyNewReactNativeApp"
```

Replace `"MyNewReactNativeApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the React Native application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-ReactNativeApp.ps1` script from the following link:

[Download New-ReactNativeApp.ps1](./scripts/New-ReactNativeApp.ps1)
