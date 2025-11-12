#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new Python application.
.DESCRIPTION
    This script initializes a new project directory for a basic Python application.
    It performs the following actions:
    - Initializes a Git repository.
    - Creates a main.py file with a standard entry point.
    - Creates an empty requirements.txt file.
    - Creates a Python virtual environment in a '.venv' folder.
    - Creates a .gitignore file with common Python ignores.
.NOTES
    Author: Gemini
    Date: 2025-11-11
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param()

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'

    $ProjectName = (Get-Location).ProviderPath.Split('\')[-1]

    $GitignoreContent = @'
# Python
__pycache__/
*.py[cod]
*$py.class

# Virtual environment
.venv/
virtualenv/
ENV/ 
env/
virtualenv/
.virtualenv/

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Jupyter Notebook
.ipynb_checkpoints

# Environments
.env
.env.*
env.bak
.envrc
'@

    $MainPyContent = @"
def main():
    """Main function"""
    print("Hello from $ProjectName!")

if __name__ == '__main__':
    main()
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

        # Create Python virtual environment
        if (-not (Test-Path -Path '.venv')) {
            if ($PSCmdlet.ShouldProcess('.venv', 'Create Python virtual environment')) {
                Write-Host "Creating Python virtual environment in '.venv'..."
                python -m venv .venv
                # Wait for the directory to exist
                $maxRetries = 50
                $retryCount = 0
                while (-not (Test-Path -Path '.venv') -and $retryCount -lt $maxRetries) {
                    Start-Sleep -Milliseconds 100
                    $retryCount++
                }
                if (-not (Test-Path -Path '.venv')) {
                    throw "Failed to create '.venv' directory after multiple retries."
                }
            }
        }
        else {
            Write-Warning "Virtual environment '.venv' already exists."
        }

        # Create main.py
        if ($PSCmdlet.ShouldProcess('main.py', 'Create file with content')) {
            Write-Host "Creating file: main.py"
            Set-Content -Path 'main.py' -Value $MainPyContent
        }

        # Create requirements.txt
        if (-not (Test-Path -Path 'requirements.txt')) {
            if ($PSCmdlet.ShouldProcess('requirements.txt', 'Create empty file')) {
                Write-Host "Creating file: requirements.txt"
                New-Item -ItemType File -Path 'requirements.txt' | Out-Null
            }
        }

        # Create .gitignore
        if (-not (Test-Path -Path '.gitignore')) {
            if ($PSCmdlet.ShouldProcess('.gitignore', 'Create file with content')) {
                Write-Host "Creating .gitignore"
                Set-Content -Path '.gitignore' -Value $GitignoreContent
            }
        }

        Write-Host "`nPython application scaffolded successfully."
        Write-Host "To activate the virtual environment, run: .\.venv\Scripts\Activate.ps1"

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_ "
    }
    finally {
        $ErrorActionPreference = $OriginalErrorActionPreference
    }
}
