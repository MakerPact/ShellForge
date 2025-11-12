param (
    [string]$ProjectName
)

begin {
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
}

# If ProjectName is not provided, use the current folder's name
if ([string]::IsNullOrEmpty($ProjectName)) {
    $ProjectName = (Get-Item -Path ".").Name
}

# Create the project directory
New-Item -ItemType Directory -Name $ProjectName

# Change into the new directory
cd $ProjectName

# Create a main.go file
@'
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
'@ | Set-Content -Path "main.go"

# Initialize a new Go module
go mod init $ProjectName
if ($LASTEXITCODE -ne 0) {
    throw "go mod init failed with exit code $LASTEXITCODE"
}

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# Create a .gitignore file
@'
# Binaries for programs and plugins
*.exe
*.exe~
*.dll
*.so
*.dylib

# Test binary, built with `go test -c`
*.test

# Output of the go coverage tool, specifically when used with LiteIDE
*.out

# Dependency directories (remove the comment below to include it)
# vendor/
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Go project: $ProjectName"
