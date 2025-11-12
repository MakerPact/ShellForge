---
layout: script
title: New-DocusaurusSite
---

## Overview

The `New-DocusaurusSite.ps1` script scaffolds a new Docusaurus site. It automates the setup of a new project directory by using `create-docusaurus`.

This script is designed to streamline the initial phase of Docusaurus site development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Wrapper Script:** This script is a wrapper around `create-docusaurus`.
-   **Project Name:** It prompts the user for the site name (or use the current folder name).
-   **Execution:** Execute `npx create-docusaurus@latest <ProjectName> classic`.
-   **Git Initialization:** Ensure Git repository is initialized correctly.

## Usage

To use the `New-DocusaurusSite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-DocusaurusSite.ps1 -ProjectName "MyNewDocusaurusSite"
```

Replace `"MyNewDocusaurusSite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Docusaurus site project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-DocusaurusSite.ps1` script from the following link:

[Download New-DocusaurusSite.ps1](./scripts/New-DocusaurusSite.ps1)
