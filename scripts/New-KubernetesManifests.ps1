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

# Create directories for Kubernetes manifests
$K8sDirs = @("deployments", "services", "ingresses", "configmaps", "secrets")
foreach ($dir in $K8sDirs) {
    New-Item -ItemType Directory -Name $dir
    # Wait for the directory to exist
    $maxRetries = 50
    $retryCount = 0
    while (-not (Test-Path -Path $dir) -and $retryCount -lt $maxRetries) {
        Start-Sleep -Milliseconds 100
        $retryCount++
    }
    if (-not (Test-Path -Path $dir)) {
        throw "Failed to create directory '$dir' after multiple retries."
    }
}

# Create example deployment.yaml
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
@'
# Kubernetes generated files
*.bak
*.tmp
.kube/
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created new Kubernetes Manifests project: $ProjectName"
Write-Host "Review the generated YAML files in 'deployments/', 'services/', etc."
