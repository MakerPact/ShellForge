param (
    [string]$ProjectName
)

$OriginalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

function Wait-Path {
    param(
        [string]$Path,
        [int]$MaxRetries = 50,
        [int]$RetryIntervalMs = 100
    )
    $retryCount = 0
    while (-not (Test-Path -Path $Path) -and $retryCount -lt $MaxRetries) {
        Start-Sleep -Milliseconds $RetryIntervalMs
        $retryCount++
    }
    if (-not (Test-Path -Path $Path)) {
        throw "Failed to find path '$Path' after $MaxRetries retries."
    }
}

try {
    # If ProjectName is not provided, use the current folder's name
    if ([string]::IsNullOrEmpty($ProjectName)) {
        $ProjectName = (Get-Item -Path ".").Name
    }

    # Create a new Angular project using the Angular CLI
    Write-Host "Creating a new Angular project: $ProjectName..."
    npx @angular/cli new $ProjectName --defaults

    # Wait for the directory to exist
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # The .gitignore file is created by the Angular CLI

    Write-Host "Successfully created a new Angular project: $ProjectName"
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    # Exit with a non-zero status code to indicate failure
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

