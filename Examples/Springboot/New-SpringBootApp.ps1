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

    # Create a new Spring Boot project using Spring Initializr via curl
    # This example creates a Maven project with Java 17 and Spring Web dependency
    $SpringInitUrl = "https://start.spring.io/starter.zip?type=maven-project&language=java&platform=jvm&jvmVersion=17&groupId=com.example&artifactId=$ProjectName&name=$ProjectName&description=Demo%20project%20for%20Spring%20Boot&packageName=com.example.$ProjectName&packaging=jar&dependencies=web"
    $ZipFileName = "$ProjectName.zip"

    Write-Host "Downloading Spring Boot project from Spring Initializr..."
    Invoke-WebRequest -Uri $SpringInitUrl -OutFile $ZipFileName

    # Extract the zip file
    Write-Host "Extracting project..."
    Expand-Archive -Path $ZipFileName -DestinationPath . -Force

    # Remove the zip file
    Write-Host "Cleaning up..."
    Remove-Item $ZipFileName

    # Wait for the directory to exist
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # The .gitignore file is created by Spring Initializr

    Write-Host "Successfully created a new Java Spring Boot App: $ProjectName"
    Write-Host "Run '.\mvnw spring-boot:run' to start the application."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

