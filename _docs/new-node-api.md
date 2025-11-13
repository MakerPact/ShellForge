---
layout: script
title: New-NodeApi
---

## Overview

The `New-NodeApi.ps1` script scaffolds a new Node.js/Express backend API. It automates the setup of a new project directory, including a Git repository, a `package.json` file, and a minimal Express server.

This script is designed to streamline the initial phase of Node.js API development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **npm Initialization:** Runs `npm init -y` to create a `package.json` file.
-   **Dependency Installation:** Installs `express` and `dotenv` as dependencies.
-   **Conventional Folder Structure:** Creates a `src` directory for your source code.
-   **Boilerplate Code:** Generates a `src/server.js` file with a minimal Express server setup.
-   **.env File:** Creates a `.env` file for environment variables.
-   **.gitignore:** Creates a `.gitignore` file with common entries for Node.js projects.

## Usage

To use the `New-NodeApi.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-NodeApi.ps1 -ProjectName "MyNewNodeApi"
```

Replace `"MyNewNodeApi"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Node.js API project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-NodeApi.ps1` script from the following link:

[Download New-NodeApi.ps1](./scripts/New-NodeApi.ps1)
