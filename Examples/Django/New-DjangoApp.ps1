param (
    [string]$ProjectName
)

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

try {
    # If ProjectName is not provided, use the current folder's name
    if ([string]::IsNullOrEmpty($ProjectName)) {
        $ProjectName = (Get-Item -Path ".").Name
    }

    # Create the project directory
    Write-Host "Creating project directory: $ProjectName..."
    New-Item -ItemType Directory -Name $ProjectName
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create a Python virtual environment
    Write-Host "Creating Python virtual environment..."
    python -m venv .venv
    Wait-Path -Path '.venv'

    # Activate virtual environment and install Django
    # Note: This part might be tricky in a PowerShell script as activation is session-specific.
    # For simplicity, we'll assume python and pip from venv are directly callable or path is set.
    # A more robust solution would involve calling the venv's python directly.
    Write-Host "Installing Django..."
    .\.venv\Scripts\pip install django

    # Create Django project
    Write-Host "Creating Django project..."
    .\.venv\Scripts\django-admin startproject $ProjectName .

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
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

# Django specific
*.sqlite3
/media
/static
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new Django project: $ProjectName"
    Write-Host "Run '.\.venv\Scripts\python manage.py runserver' to start the development server."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

