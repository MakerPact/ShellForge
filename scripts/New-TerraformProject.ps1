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

# Initialize a new Git repository
git init

# Create main.tf
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
@'
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}
'@ | Set-Content -Path "variables.tf"

# Create outputs.tf
@'
output "project_name" {
  description = "The name of the Terraform project."
  value       = "$ProjectName"
}
'@ | Set-Content -Path "outputs.tf"

# Create a .gitignore file
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
