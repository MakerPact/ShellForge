param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Gatsby project using the Gatsby CLI
npx gatsby new $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# The .gitignore file is created by the Gatsby CLI

Write-Host "Successfully created a new Gatsby project: $ProjectName"
