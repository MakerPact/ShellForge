---
layout: script
title: New-DockerComposeProject
---

## Overview

The `New-DockerComposeProject.ps1` script scaffolds a new Docker Compose project. It automates the setup of a new project directory, including a Git repository, a `docker-compose.yml` file with example services, and basic application files.

This script is designed to streamline the initial phase of Docker Compose development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Docker Compose File:** Creates a `docker-compose.yml` with example `nginx`, `php-fpm`, and `postgres` services.
-   **Example Application:** Creates an `app` directory with an `index.php` and an `nginx` directory with a `default.conf`.
-   **.gitignore:** Creates a `.gitignore` file with common Docker-specific entries.

## Usage

To use the `New-DockerComposeProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-DockerComposeProject.ps1 -ProjectName "MyNewDockerComposeProject"
```

Replace `"MyNewDockerComposeProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Docker Compose project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-DockerComposeProject.ps1` script from the following link:

[Download New-DockerComposeProject.ps1](./scripts/New-DockerComposeProject.ps1)
