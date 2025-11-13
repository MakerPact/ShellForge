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

    # Create the project directory
    Write-Host "Creating project directory: $ProjectName..."
    New-Item -ItemType Directory -Name $ProjectName
    Wait-Path -Path $ProjectName

    # Change into the new directory
    Set-Location -Path $ProjectName

    # Create a src directory
    Write-Host "Creating 'src' directory..."
    New-Item -ItemType Directory -Name "src"
    Wait-Path -Path 'src'

    # Create a main.cpp file
    Write-Host "Creating 'src/main.cpp'..."
@'
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
'@ | Set-Content -Path "src/main.cpp"

    # Create a Makefile
    Write-Host "Creating Makefile..."
@'
CXX = g++
CXXFLAGS = -std=c++11 -Wall

SRCS = src/main.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = main

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(EXEC) $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(EXEC)
'@ | Set-Content -Path "Makefile"

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
*.o
main
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new C++ project: $ProjectName"
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

