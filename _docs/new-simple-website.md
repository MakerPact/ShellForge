---
layout: script
title: New-SimpleWebsite
---

## Overview

The `New-SimpleWebsite.ps1` script scaffolds a new simple website. It automates the setup of a new project directory, including a Git repository, an `index.html` file, a `css` folder with a `style.css` file, a `js` folder with a `main.js` file, and an `images` folder.

This script is designed to streamline the initial phase of simple website development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Boilerplate Code:** Creates an `index.html` file with basic HTML5 boilerplate.
-   **Conventional Folder Structure:** Creates a `css` folder with a `style.css` file, a `js` folder with a `main.js` file, and an `images` folder.
-   **.gitignore:** Creates a `.gitignore` file with common entries for web development.

## Usage

To use the `New-SimpleWebsite.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-SimpleWebsite.ps1 -ProjectName "MyNewSimpleWebsite"
```

Replace `"MyNewSimpleWebsite"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the simple website project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-SimpleWebsite.ps1` script from the following link:

[Download New-SimpleWebsite.ps1](./scripts/New-SimpleWebsite.ps1)
