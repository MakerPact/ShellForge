param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Next.js project using create-next-app
npx create-next-app $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# The .gitignore file is created by create-next-app

Write-Host "Successfully created a new Next.js project: $ProjectName"
