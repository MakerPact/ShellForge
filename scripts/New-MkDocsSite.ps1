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

# Install MkDocs
Write-Host "Installing MkDocs..."
.\.venv\Scripts\pip install mkdocs
if ($LASTEXITCODE -ne 0) {
    throw "pip install failed with exit code $LASTEXITCODE"
}

# Create MkDocs project
Write-Host "Creating MkDocs project..."
.\.venv\Scripts\mkdocs new .
if ($LASTEXITCODE -ne 0) {
    throw "mkdocs new failed with exit code $LASTEXITCODE"
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

# MkDocs specific
/site
.DS_Store
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new MkDocs site: $ProjectName"
Write-Host "Run '.\.venv\Scripts\mkdocs serve' to start the development server."
