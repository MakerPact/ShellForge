param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Svelte project using Vite
npx create-vite $ProjectName --template svelte

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# Create a .gitignore file
@'
/node_modules
/dist
.env
.env.*
*.local
*.log
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Svelte project: $ProjectName"
