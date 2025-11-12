param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Flutter project
flutter create $ProjectName

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# The .gitignore file is created by Flutter

Write-Host "Successfully created a new Flutter project: $ProjectName"
