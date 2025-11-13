---
layout: script
title: New-KubernetesManifests
---

## Overview

The `New-KubernetesManifests.ps1` script scaffolds a new Kubernetes Manifests project. It automates the setup of a new project directory, including a Git repository and a structured set of directories for various Kubernetes resource types (deployments, services, ingresses, configmaps, secrets) with example YAML files.

This script is designed to streamline the initial phase of Kubernetes manifest development, enforce a consistent project structure, and reduce repetitive setup tasks.

## Features

-   **Git Initialization:** Automatically initializes a new Git repository in the project's root directory.
-   **Structured Directories:** Creates dedicated directories for `deployments`, `services`, `ingresses`, `configmaps`, and `secrets`.
-   **Example Manifests:** Provides basic example YAML files for a Deployment and a Service.
-   **.gitignore:** Creates a `.gitignore` file with common Kubernetes-specific entries.

## Usage

To use the `New-KubernetesManifests.ps1` script, open a PowerShell terminal, navigate to the directory where you want to create your new project, and run the following command:

```powershell
.\New-KubernetesManifests.ps1 -ProjectName "MyNewK8sProject"
```

Replace `"MyNewK8sProject"` with the desired name for your project.

### Parameters

-   `ProjectName` (Mandatory): The name of the Kubernetes Manifests project. This will also be the name of the project's root directory.

## How to Download

You can download the `New-KubernetesManifests.ps1` script from the following link:

[Download New-KubernetesManifests.ps1](./scripts/New-KubernetesManifests.ps1)
