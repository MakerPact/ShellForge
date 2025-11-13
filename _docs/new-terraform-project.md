---
layout: script
title: New-TerraformProject
---

## Overview

The `New-TerraformProject.ps1` script scaffolds a new Terraform project. It automates the setup of a new project directory, including a Git repository and basic Terraform configuration files (`main.tf`, `variables.tf`, `outputs.tf`).

This script is designed to streamline the initial phase of Terraform infrastructure-as-code development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Basic Terraform Files:** Creates `main.tf`, `variables.tf`, and `outputs.tf` with example AWS VPC configuration.
-   **.gitignore:** Creates a `.gitignore` file with common Terraform-specific entries.

## Usage

To use the `New-TerraformProject.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-TerraformProject.ps1 -ProjectName "MyNewTerraformProject"
```

Replace `"MyNewTerraformProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Terraform project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-TerraformProject.ps1` script from the following link:

[Download New-TerraformProject.ps1](./scripts/New-TerraformProject.ps1)
