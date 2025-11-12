---
layout: script
title: New-HugoSite
---

## Overview

The `New-HugoSite.ps1` script scaffolds a new Hugo static site. It automates the setup of a new project directory by using the `hugo new site` command.

This script is designed to streamline the initial phase of Hugo site development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `hugo new site` command.
-   **Project Name:** It prompts the user for the site name (or use the current folder name).
-   **Execution:** Execute `hugo new site <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-HugoSite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-HugoSite.ps1 -ProjectName "MyNewHugoSite"
```

Replace `"MyNewHugoSite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Hugo site project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-HugoSite.ps1` script from the following link:

[Download New-HugoSite.ps1](./scripts/New-HugoSite.ps1)
