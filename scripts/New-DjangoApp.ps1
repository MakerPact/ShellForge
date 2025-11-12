param (
    [string]$ProjectName
)

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
}

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# Create a Python virtual environment
python -m venv .venv
if ($LASTEXITCODE -ne 0) {
    throw "python -m venv failed with exit code $LASTEXITCODE"
}

# Activate virtual environment and install Django
# Note: This part might be tricky in a PowerShell script as activation is session-specific.
# For simplicity, we'll assume python and pip from venv are directly callable or path is set.
# A more robust solution would involve calling the venv's python directly.
Write-Host "Installing Django..."
.\.venv\Scripts\pip install django
if ($LASTEXITCODE -ne 0) {
    throw "pip install failed with exit code $LASTEXITCODE"
}

# Create Django project
Write-Host "Creating Django project..."
.\.venv\Scripts\django-admin startproject $ProjectName .
if ($LASTEXITCODE -ne 0) {
    throw "django-admin startproject failed with exit code $LASTEXITCODE"
}

# Create a .gitignore file
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
