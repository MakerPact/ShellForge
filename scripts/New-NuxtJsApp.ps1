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

# Create a new Nuxt.js project using create-nuxt-app
npx create-nuxt-app $ProjectName
if ($LASTEXITCODE -ne 0) {
    throw "npx create-nuxt-app failed with exit code $LASTEXITCODE"
}

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# The .gitignore file is created by create-nuxt-app

Write-Host "Successfully created a new Nuxt.js project: $ProjectName"
