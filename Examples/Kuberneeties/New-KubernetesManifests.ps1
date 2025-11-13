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

    # Create directories for Kubernetes manifests
    $K8sDirs = @("deployments", "services", "ingresses", "configmaps", "secrets")
    foreach ($dir in $K8sDirs) {
        Write-Host "Creating directory: $dir..."
        New-Item -ItemType Directory -Name $dir
        Wait-Path -Path $dir
    }

    # Create example deployment.yaml
    Write-Host "Creating 'deployments/example-deployment.yaml'..."
@'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
  labels:
    app: example
spec:
  replicas: 1
  selector:
    matchLabels:
      app: example
  template:
    metadata:
      labels:
        app: example
    spec:
      containers:
      - name: example-container
        image: nginx:latest
        ports:
        - containerPort: 80
'@ | Set-Content -Path "deployments/example-deployment.yaml"

    # Create example service.yaml
    Write-Host "Creating 'services/example-service.yaml'..."
@'
apiVersion: v1
kind: Service
metadata:
  name: example-service
spec:
  selector:
    app: example
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
'@ | Set-Content -Path "services/example-service.yaml"

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
# Kubernetes generated files
*.bak
*.tmp
.kube/
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created new Kubernetes Manifests project: $ProjectName"
    Write-Host "Review the generated YAML files in 'deployments/', 'services/', etc."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

