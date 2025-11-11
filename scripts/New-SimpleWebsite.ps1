#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new, simple website project.
.DESCRIPTION
    This script initializes a new project directory for a simple static website.
    It performs the following actions:
    - Initializes a Git repository.
    - Creates a basic index.html file.
    - Creates css/style.css, js/main.js, and an images folder.
    - Creates a .gitignore file with common web development ignores.
.NOTES
    Author: Gemini
    Date: 2025-11-11
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param()

begin {
    # Set ErrorActionPreference to Stop to handle errors robustly
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'

    # Define file and folder structures
    $ProjectName = (Get-Location).ProviderPath.Split('\')[-1]
    $FilesToCreate = @(
        'index.html',
        'css/style.css',
        'js/main.js'
    )
    $FoldersToCreate = @(
        'css',
        'js',
        'images'
    )
    $GitignoreContent = @'
# Dependencies
/node_modules

# Build artifacts
/dist
/build

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Other
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local
'@

    $IndexHtmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$ProjectName</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Welcome to $ProjectName</h1>
    <script src="js/main.js"></script>
</body>
</html>
"@
}

process {
    try {
        # Git Initialization
        if (-not (Test-Path -Path '.git')) {
            if ($PSCmdlet.ShouldProcess('current directory', 'Initialize Git repository')) {
                Write-Host "Initializing Git repository..."
                git init | Out-Null
            }
        }
        else {
            Write-Warning "Git repository already exists in this directory."
        }

        # Create Folders
        foreach ($folder in $FoldersToCreate) {
            if (-not (Test-Path -Path $folder)) {
                if ($PSCmdlet.ShouldProcess($folder, 'Create directory')) {
                    Write-Host "Creating directory: $folder"
                    New-Item -ItemType Directory -Path $folder | Out-Null
                }
            }
        }

        # Create Files
        if ($PSCmdlet.ShouldProcess('index.html', 'Create file with content')) {
            Write-Host "Creating file: index.html"
            Set-Content -Path 'index.html' -Value $IndexHtmlContent
        }
        if ($PSCmdlet.ShouldProcess('css/style.css', 'Create empty file')) {
            Write-Host "Creating file: css/style.css"
            New-Item -ItemType File -Path 'css/style.css' | Out-Null
        }
        if ($PSCmdlet.ShouldProcess('js/main.js', 'Create empty file')) {
            Write-Host "Creating file: js/main.js"
            New-Item -ItemType File -Path 'js/main.js' | Out-Null
        }

        # Create .gitignore
        if (-not (Test-Path -Path '.gitignore')) {
            if ($PSCmdlet.ShouldProcess('.gitignore', 'Create file with content')) {
                Write-Host "Creating .gitignore"
                Set-Content -Path '.gitignore' -Value $GitignoreContent
            }
        }

        Write-Host "`nProject '$ProjectName' scaffolded successfully."
        Write-Host "Run 'git add .' and 'git commit -m \"Initial commit\"' to save changes."

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_ "
    }
    finally {
        # Restore original ErrorActionPreference
        $ErrorActionPreference = $OriginalErrorActionPreference
    }
}
