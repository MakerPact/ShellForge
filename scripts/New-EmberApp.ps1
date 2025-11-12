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

# Create a new Ember project using the Ember CLI
npx ember-cli new $ProjectName --skip-git
if ($LASTEXITCODE -ne 0) {
    throw "npx ember-cli new failed with exit code $LASTEXITCODE"
}

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# The .gitignore file is created by the Ember CLI

Write-Host "Successfully created a new Ember project: $ProjectName"
