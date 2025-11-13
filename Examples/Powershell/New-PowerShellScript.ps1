#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new PowerShell script project.
.DESCRIPTION
    This script initializes a new project directory for a PowerShell module.
    It performs the following actions:
    - Initializes a Git repository.
    - Creates a module file (.psm1).
    - Creates a module manifest file (.psd1).
    - Creates a 'tests' folder with a Pester test file.
    - Creates a .gitignore file.
.NOTES
    Author: Gemini
    Date: 2025-11-11
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param()

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'

    function Wait-Path {
        param(
            [string]$Path,
            [int]$MaxRetries = 50,
            [int]$RetryIntervalMs = 100
        )
        $retryCount = 0
        while (-not (Test-Path -Path $Path) -and $retryCount -lt $MaxRetries) {
            Start-Sleep -Milliseconds $RetryIntervalMs
            $retryCount++
        }
        if (-not (Test-Path -Path $Path)) {
            throw "Failed to find path '$Path' after $MaxRetries retries."
        }
    }

    # Get the project name from the current directory name
    $ProjectName = (Get-Location).ProviderPath.Split('\')[-1]

    $GitignoreContent = @'
# PowerShell module files
*.psd1
*.psm1

# User-specific files
*.suo
*.user
*.userosscache
*.sln.docstates

# Build artifacts
/bin
/obj
/packages
/dist
/build

# Pester
/Pester
/Pester*.zip
/Pester*.nupkg
/Pester*.tar.gz
/Pester*.tar.bz2

# PSDeploy
.psdeploy.ps1
.psdeploy.psm1
.psdeploy.psd1
psdeploy.ps1
psdeploy.psm1
psdeploy.psd1
'@

    $TestFileContent = @"
# Requires -Module Pester
Import-Module -Name Pester -MinimumVersion 5.0.0
`$here = (Split-Path -Parent `$MyInvocation.MyCommand.Path)
`$sut = (Resolve-Path "`$here/../$ProjectName.psm1")

Describe "$ProjectName" {
    BeforeAll {
        Import-Module `$sut
    }

    It "Should do something" {
        { 1 | Should -Be 1 } | Should -Not -Throw
    }
}
"@
}

process {
    try {
        # Git Initialization
        if (-not (Test-Path -Path '.git')) {
            if ($PSCmdlet.ShouldProcess('current directory', 'Initialize Git repository')) {
                Write-Host "Initializing Git repository..."
                git init | Out-Null
            }
        }
        else {
            Write-Warning "Git repository already exists in this directory."
        }

        # Create module file
        $ModulePath = "$ProjectName.psm1"
        if (-not (Test-Path -Path $ModulePath)) {
            if ($PSCmdlet.ShouldProcess($ModulePath, 'Create empty module file')) {
                Write-Host "Creating module file: $ModulePath"
                New-Item -ItemType File -Path $ModulePath | Out-Null
            }
        }

        # Create module manifest
        $ManifestPath = "$ProjectName.psd1"
        if (-not (Test-Path -Path $ManifestPath)) {
            if ($PSCmdlet.ShouldProcess($ManifestPath, 'Create module manifest')) {
                Write-Host "Creating module manifest: $ManifestPath"
                New-ModuleManifest -Path $ManifestPath -RootModule $ModulePath -Author "Your Name" -Description "A new PowerShell module." -CompanyName "Unknown"
            }
        }

        # Create tests directory
        if (-not (Test-Path -Path 'tests')) {
            if ($PSCmdlet.ShouldProcess('tests', 'Create directory')) {
                Write-Host "Creating directory: tests"
                New-Item -ItemType Directory -Path 'tests' | Out-Null
                Wait-Path -Path 'tests'
            }
        }

        # Create Pester test file
        $TestPath = "tests/$ProjectName.Tests.ps1"
        if (-not (Test-Path -Path $TestPath)) {
            if ($PSCmdlet.ShouldProcess($TestPath, 'Create Pester test file')) {
                Write-Host "Creating Pester test file: $TestPath"
                Set-Content -Path $TestPath -Value $TestFileContent
            }
        }

        # Create .gitignore
        if (-not (Test-Path -Path '.gitignore')) {
            if ($PSCmdlet.ShouldProcess('.gitignore', 'Create file with content')) {
                Write-Host "Creating .gitignore"
                Set-Content -Path '.gitignore' -Value $GitignoreContent
            }
        }

        Write-Host "`nPowerShell script project scaffolded successfully."
        Write-Host "You can now add functions to your '$ProjectName.psm1' file and tests to 'tests/$ProjectName.Tests.ps1'."

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_"
        exit 1
    }
    finally {
        $ErrorActionPreference = $OriginalErrorActionPreference
    }
}

