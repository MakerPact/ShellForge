#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new React application using Vite.
.DESCRIPTION
    This script initializes a new React project using the Vite build tool.
    It performs the following actions:
    - Runs 'npx create-vite . --template react'.
    - Runs 'npm install' to fetch dependencies.
    - Initializes a Git repository.
.NOTES
    Author: Gemini
    Date: 2025-11-11
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param()

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
}

process {
    try {
        # Check if the directory is empty.
        if ((Get-ChildItem).Count -gt 0) {
            Write-Error "The current directory is not empty. This script must be run in an empty directory."
            return
        }

        # Vite Initialization
        if ($PSCmdlet.ShouldProcess('current directory', 'Run create-vite')) {
            Write-Host "Running 'npx -y create-vite . --template react'..."
            Write-Host "This step may take a few moments..."
            # The '-y' flag automatically says yes to the npx prompt.
            # Piping 'n' to handle potential experimental feature prompts.
            echo "n" | npx -y create-vite . --template react
        }

        # Install dependencies
        if (Test-Path -Path 'package.json') {
            if ($PSCmdlet.ShouldProcess('current directory', 'Run npm install')) {
                Write-Host "Running 'npm install'..."
                Write-Host "This is the longest step and can take several minutes depending on your network connection."
                npm install
            }
        } else {
            Write-Warning "'package.json' not found. Skipping 'npm install'."
        }

        # Git Initialization
        if (-not (Test-Path -Path '.git')) {
            if ($PSCmdlet.ShouldProcess('current directory', 'Initialize Git repository')) {
                Write-Host "Initializing Git repository..."
                git init
                git add .
                git commit -m "Initial commit: Scaffolded React app with Vite"
            }
        }
        else {
            Write-Warning "Git repository already exists in this directory."
        }

        Write-Host "`nReact application scaffolded successfully."
        Write-Host "Run 'npm run dev' to start the development server."

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_"
    }
    finally {
        $ErrorActionPreference = $OriginalErrorActionPreference
    }
}
