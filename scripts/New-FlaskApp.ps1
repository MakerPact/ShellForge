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

# Install Flask
Write-Host "Installing Flask..."
.\.venv\Scripts\pip install Flask
if ($LASTEXITCODE -ne 0) {
    throw "pip install failed with exit code $LASTEXITCODE"
}

# Create app.py
@'
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)
'@ | Set-Content -Path "app.py"

# Create requirements.txt
@'
Flask
'@ | Set-Content -Path "requirements.txt"

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
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Flask project: $ProjectName"
Write-Host "Run '.\.venv\Scripts\python app.py' to start the development server."
