param (
    [string]$ProjectName
)

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
Expand-Archive -Path $ZipFileName -DestinationPath . -Force

# Remove the zip file
Remove-Item $ZipFileName

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

# The .gitignore file is created by Spring Initializr

Write-Host "Successfully created a new Java Spring Boot App: $ProjectName"
Write-Host "Run '.\mvnw spring-boot:run' to start the application."
