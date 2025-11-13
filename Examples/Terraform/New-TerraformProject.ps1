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

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create main.tf
    Write-Host "Creating main.tf..."
@'
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # You can change this to your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "$ProjectName-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
'@ | Set-Content -Path "main.tf"

    # Create variables.tf
    Write-Host "Creating variables.tf..."
@'
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}
'@ | Set-Content -Path "variables.tf"

    # Create outputs.tf
    Write-Host "Creating outputs.tf..."
@'
output "project_name" {
  description = "The name of the Terraform project."
  value       = "$ProjectName"
}
'@ | Set-Content -Path "outputs.tf"

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
.terraform/
*.tfplan
*.tfstate
*.tfstate.backup
.terraform.lock.hcl
crash.log
crash.*.log
*.tfvars
*.tfvars.json
!*.tfvars.example
!*.tfvars.json.example
.vscode/
.idea/
*.zip
*.tar.gz
*.tgz
*.rar
*.7z
*.bak
*.swp
*.swo
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new Terraform project: $ProjectName"
    Write-Host "Run 'terraform init' and 'terraform plan' to get started."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

