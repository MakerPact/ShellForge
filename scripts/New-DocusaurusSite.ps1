param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Docusaurus site
npx create-docusaurus@latest $ProjectName classic

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# The .gitignore file is created by Docusaurus

Write-Host "Successfully created a new Docusaurus site: $ProjectName"
