---
layout: script
title: New-SpringBootApp
---

## Overview

The `New-SpringBootApp.ps1` script scaffolds a new Java Spring Boot application. It automates the setup of a new project directory by using the Spring Initializr service via `Invoke-WebRequest`.

This script is designed to streamline the initial phase of Spring Boot application development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Spring Initializr Integration:** Downloads a pre-configured Spring Boot project from `start.spring.io`.
-   **Project Name:** Uses the provided project name for the generated application.
-   **Git Initialization:** Ensures a Git repository is initialized correctly.
-   **.gitignore:** The downloaded project includes a `.gitignore` file.

## Usage

To use the `New-SpringBootApp.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-SpringBootApp.ps1 -ProjectName "MyNewSpringBootApp"
```

Replace `"MyNewSpringBootApp"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Spring Boot application project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-SpringBootApp.ps1` script from the following link:

[Download New-SpringBootApp.ps1](./scripts/New-SpringBootApp.ps1)
