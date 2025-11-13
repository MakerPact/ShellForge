---
layout: script
title: New-JekyllSite
---

## Overview

The `New-JekyllSite.ps1` script scaffolds a new Jekyll static site. It automates the setup of a new project directory by using the `jekyll new` command.

This script is designed to streamline the initial phase of Jekyll site development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around the `jekyll new` command.
-   **Project Name:** It prompts the user for the site name (or use the current folder name).
-   **Execution:** Execute `jekyll new <ProjectName>`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-JekyllSite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-JekyllSite.ps1 -ProjectName "MyNewJekyllSite"
```

Replace `"MyNewJekyllSite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Jekyll site project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-JekyllSite.ps1` script from the following link:

[Download New-JekyllSite.ps1](./scripts/New-JekyllSite.ps1)
