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

# Initialize a new Git repository
git init
if ($LASTEXITCODE -ne 0) {
    throw "git init failed with exit code $LASTEXITCODE"
}

# Create directories for Kubernetes manifests
$K8sDirs = @("deployments", "services", "ingresses", "configmaps", "secrets")
foreach ($dir in $K8sDirs) {
    New-Item -ItemType Directory -Name $dir
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
