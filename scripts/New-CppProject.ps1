param (
    [string]$ProjectName
)

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName
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

# Create a src directory
New-Item -ItemType Directory -Name "src"
# Wait for the directory to exist
$maxRetries = 50
$retryCount = 0
while (-not (Test-Path -Path 'src') -and $retryCount -lt $maxRetries) {
    Start-Sleep -Milliseconds 100
    $retryCount++
}
if (-not (Test-Path -Path 'src')) {
    throw "Failed to create 'src' directory after multiple retries."
}

# Create a main.cpp file
@'
#include <iostream>

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
'@ | Set-Content -Path "src/main.cpp"

# Create a Makefile
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
git init

# Create a .gitignore file
@'
*.o
main
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new C++ project: $ProjectName"
