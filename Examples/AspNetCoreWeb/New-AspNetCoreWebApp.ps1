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
    Write-Host "Checking for dotnet SDK..."
    $sdkList = dotnet --list-sdks | Out-String
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($sdkList)) {
        Write-Host "dotnet SDK not found, installing..."
        $dotnetInstallerUri = "https://dot.net/v1/dotnet-install.ps1"
        $tempPath = [System.IO.Path]::GetTempPath()
        $installerPath = Join-Path $tempPath "dotnet-install.ps1"
        Invoke-WebRequest -Uri $dotnetInstallerUri -OutFile $installerPath
        & $installerPath -Channel "LTS" -InstallDir ".dotnet"
        $dotnetPath = Join-Path (Resolve-Path ".dotnet") "dotnet.exe"
        Write-Host "dotnet installed at: $dotnetPath"
    } else {
        Write-Host "dotnet SDK found."
        $dotnetPath = "dotnet"
    }

    # If ProjectName is not provided, use the current folder's name
    if ([string]::IsNullOrEmpty($ProjectName)) {
        $ProjectName = (Get-Item -Path ".").Name
    }

    # Create a new ASP.NET Core Web App
    Write-Host "Creating a new ASP.NET Core Web App: $ProjectName..."
    & $dotnetPath new webapp -n $ProjectName

    # Wait for the directory to exist
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # The .gitignore file is created by dotnet new

    Write-Host "Successfully created a new ASP.NET Core Web App: $ProjectName"
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    Write-Host "Press Enter to exit..."
    Read-Host
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

