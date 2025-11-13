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

    # Create a new Next.js project using create-next-app
    Write-Host "Creating a new Next.js project: $ProjectName..."
    npx create-next-app $ProjectName

    # Wait for the directory to exist
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # The .gitignore file is created by create-next-app

    Write-Host "Successfully created a new Next.js project: $ProjectName"
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

