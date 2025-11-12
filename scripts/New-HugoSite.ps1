param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Hugo site
hugo new site $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# Create a .gitignore file
@'
/public
/resources
/data
/themes
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Hugo site: $ProjectName"
