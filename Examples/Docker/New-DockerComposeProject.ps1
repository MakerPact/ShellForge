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

    # Create docker-compose.yml
    Write-Host "Creating docker-compose.yml..."
@'
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx:/etc/nginx/conf.d
    depends_on:
      - app

  app:
    image: php:8.2-fpm
    volumes:
      - ./app:/var/www/html

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: mydatabase
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
'@ | Set-Content -Path "docker-compose.yml"

    # Create example app directory and index.php
    Write-Host "Creating 'app' directory..."
    New-Item -ItemType Directory -Name "app"
    Wait-Path -Path 'app'
    Write-Host "Creating 'app/index.php'..."
@'
<?php echo "Hello from Docker Compose!"; ?>
'@ | Set-Content -Path "app/index.php"

    # Create example nginx directory and default.conf
    Write-Host "Creating 'nginx' directory..."
    New-Item -ItemType Directory -Name "nginx"
    Wait-Path -Path 'nginx'
    Write-Host "Creating 'nginx/default.conf'..."
@'
server {
    listen 80;
    index index.php index.html;
    error_log /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/html;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }

    location / {
        try_files $uri $uri/ /index.php?$query_string;
        gzip_static on;
    }
}
'@ | Set-Content -Path "nginx/default.conf"

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
.env
.env.*
docker-compose.override.yml
*.log
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new Docker Compose project: $ProjectName"
    Write-Host "Run 'docker-compose up -d' to start the services."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

