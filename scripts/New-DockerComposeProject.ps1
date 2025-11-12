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

# Create docker-compose.yml
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
New-Item -ItemType Directory -Name "app"
@'
<?php echo "Hello from Docker Compose!"; ?>
'@ | Set-Content -Path "app/index.php"

# Create example nginx directory and default.conf
New-Item -ItemType Directory -Name "nginx"
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
@'
.env
.env.*
docker-compose.override.yml
*.log
'@ | Set-Content -Path ".gitignore"

Write-Host "Successfully created a new Docker Compose project: $ProjectName"
Write-Host "Run 'docker-compose up -d' to start the services."
