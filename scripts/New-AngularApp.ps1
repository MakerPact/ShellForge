param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create a new Angular project using the Angular CLI
npx @angular/cli new $ProjectName --defaults

# Wait for the directory to exist
$maxRetries = 50
$retryCount = 0
while (-not (Test-Path -Path $ProjectName) -and $retryCount -lt $maxRetries) {
    Start-Sleep -Milliseconds 100
    $retryCount++
}
if (-not (Test-Path -Path $ProjectName)) {
    throw "Failed to create project directory '$ProjectName' after multiple retries."
}

# Change into the new directory
cd $ProjectName

# Initialize a new Git repository
git init

# The .gitignore file is created by the Angular CLI

Write-Host "Successfully created a new Angular project: $ProjectName"
