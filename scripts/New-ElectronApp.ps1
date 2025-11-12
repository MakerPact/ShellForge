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

# Initialize a new npm project
npm init -y

# Install Electron
npm install electron --save-dev

# Create main.js
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
(Get-Content package.json | ConvertFrom-Json).scripts.start = "electron ."
(Get-Content package.json | ConvertFrom-Json).main = "main.js"
(Get-Content package.json) | Set-Content package.json

# Initialize a new Git repository
git init

# Create a .gitignore file
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
