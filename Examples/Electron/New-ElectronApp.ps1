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

    # Initialize a new npm project
    Write-Host "Initializing npm project..."
    npm init -y

    # Install Electron
    Write-Host "Installing Electron..."
    npm install electron --save-dev

    # Create main.js
    Write-Host "Creating main.js..."
@'
const { app, BrowserWindow } = require('electron')

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true
    }
  })

  win.loadFile('index.html')
}

app.whenReady().then(createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})
'@ | Set-Content -Path "main.js"

    # Create index.html
    Write-Host "Creating index.html..."
@'
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
  </head>
  <body>
    <h1>Hello World!</h1>
    We are using Node.js <span id="node-version"></span>,
    Chromium <span id="chrome-version"></span>,
    and Electron <span id="electron-version"></span>.
  </body>
</html>
'@ | Set-Content -Path "index.html"

    # Update package.json with start script
    Write-Host "Updating package.json..."
    (Get-Content package.json | ConvertFrom-Json).scripts.start = "electron ."
    (Get-Content package.json | ConvertFrom-Json).main = "main.js"
    (Get-Content package.json) | Set-Content package.json

    # Initialize a new Git repository
    Write-Host "Initializing Git repository..."
    git init

    # Create a .gitignore file
    Write-Host "Creating .gitignore..."
@'
/node_modules
/dist
.env
.env.*
*.local
*.log
'@ | Set-Content -Path ".gitignore"

    Write-Host "Successfully created a new Electron App: $ProjectName"
    Write-Host "Run 'npm start' to run the application."
}
catch {
    Write-Error "An error occurred during project scaffolding: $_"
    exit 1
}
finally {
    $ErrorActionPreference = $OriginalErrorActionPreference
}

