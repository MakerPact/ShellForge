---
layout: script
title: New-EleventySite
---

## Overview

The `New-EleventySite.ps1` script scaffolds a new Eleventy (11ty) static site. It automates the setup of a new project directory, including a basic Eleventy configuration, source files, and a Git repository.

This script is designed to streamline the initial phase of Eleventy site development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **npm Initialization:** Initializes a new npm project.
-   **Eleventy Installation:** Installs Eleventy as a development dependency.
-   **Basic Configuration:** Creates a `.eleventy.js` configuration file.
-   **Boilerplate Content:** Creates a `src` directory with an `index.md` and a basic Nunjucks layout.
-   **Git Initialization:** Ensures a Git repository is initialized correctly.

## Usage

To use the `New-EleventySite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-EleventySite.ps1 -ProjectName "MyNewEleventySite"
```

Replace `"MyNewEleventySite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Eleventy site project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-EleventySite.ps1` script from the following link:

[Download New-EleventySite.ps1](./scripts/New-EleventySite.ps1)
