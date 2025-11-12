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

# Create a new Vue project using Vite
npx create-vite $ProjectName --template vue
if ($LASTEXITCODE -ne 0) {
    throw "npx create-vite failed with exit code $LASTEXITCODE"
}

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# Create a .gitignore file
@'
/node_modules
/dist
.env
.env.*
*.local
*.log
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Vue project: $ProjectName"
