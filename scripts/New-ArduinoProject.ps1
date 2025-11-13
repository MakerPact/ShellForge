#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new Arduino project with a custom debug library and QOL helpers.
.DESCRIPTION
    This script initializes a new project directory for an Arduino sketch.
    It performs the following actions:
    - Initializes a Git repository.
    - Creates a main .ino file, pre-configured to use the new helpers.
    - Creates a 'src/config.h' file for global settings (pins, baud, debug flags).
    - Creates a 'platformio.ini' file for easy integration with PlatformIO/VS Code.
    - Creates a powerful 'DPrint' library (header and C++) with template-based
      printing and printf support.
    - Creates a 'SimpleTimer' library for non-blocking delays.
    - Creates a 'StatusLED' library for managing visual status indicators.
    - Creates a 'SettingsManager' (header-only) library for easy EEPROM saves/loads.
    - Creates dedicated folders for documentation, datasheets, and images.
    - Creates an improved .gitignore file.
    - Creates an updated README.md explaining the new features.
.NOTES
    Author: Gemini
    Date: 2025-11-13
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory=$true, HelpMessage="The name of the Arduino project.")]
    [string]$ProjectName,

    [Parameter(HelpMessage="Enable or disable the custom debug print feature by default.")]
    [bool]$EnableDebugPrint = $true
)

begin {
    # Set ErrorActionPreference to Stop to handle errors robustly
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

    # Define paths
    $ProjectRoot = Join-Path (Get-Location).ProviderPath $ProjectName
    $SrcDir = Join-Path $ProjectRoot 'src'
    $LibDir = Join-Path $ProjectRoot 'lib'
    $ScriptLibDir = Join-Path $PSScriptRoot 'lib'

    # Documentation paths
    $DocumentationDir = Join-Path $ProjectRoot 'documentation'
    $ProjectDatasheetsDir = Join-Path $ProjectRoot 'project_datasheets'
    $ImagesDir = Join-Path $ProjectRoot 'images'

    # --- Content for files ---

    # .gitignore content (Removed /lib/ ignore, as we are versioning our custom libs)
    $GitignoreContent = @'
# Arduino IDE and build artifacts
*.hex
*.elf
*.bin
*.lst
*.map
*.eep
*.s
*.o
*.d
*.sym
*.suo
*.user
*.vcproj.filters
*.filters
*.aps
*.bak
*.ncb
*.opensdf
*.sdf
*.ipch
*.obj
*.pch
*.pdb
*.idb
*.res
*.tlog
*.vspscc
*.vssscc
*.buildlog
*.log
*.plg
*.lastbuildstate
*.opendb
*.rcproj
*.sln
*.vcxproj
*.vcxproj.user
*.code-workspace

# OS generated files
.DS_Store
Thumbs.db

# Project specific
.vscode/
.build/
.pio/
.idea/
'@

    # src/config.h content
    $ConfigHContent = @"
#ifndef config_h
#define config_h

#include <Arduino.h>

// --- Debug & Serial ---
// Set to true to enable debug messages, false to disable.
const bool DEBUG_PRINT_ENABLED = $($EnableDebugPrint.ToString().ToLower());
const long BAUD_RATE = 115200;

// --- Pin Definitions ---
// Assign descriptive names to your pins
const int STATUS_LED_PIN = LED_BUILTIN;
// const int SENSOR_PIN = A0;
// const int BUTTON_PIN = 2;

// --- Tuning Parameters ---
// Intervals for timers (in milliseconds)
const unsigned long SENSOR_READ_INTERVAL = 1000;
const unsigned long HEARTBEAT_INTERVAL = 5000;


#endif
"@

    # platformio.ini content
    $PlatformioIniContent = @"
; PlatformIO Project Configuration File
;
;   BuildOptions: http://docs.platformio.org/page/projectconf/build_options.html
;   LibraryOptions: http://docs.platformio.org/page/projectconf/library_options.html
;   UploadOptions: http://docs.platformio.org/page/projectconf/upload_options.html
;
; Please visit documentation for the other options and examples
; http://docs.platformio.org/page/projectconf.html

[env:uno]
platform = atmelavr
board = uno
framework = arduino
monitor_speed = 115200
lib_deps =
    ; Add external library dependencies here
    ; ex: bblanchon/ArduinoJson@^6.0.0

; Ignore our self-managed libs in the 'lib' folder
; from the Library Dependency Finder (LDF)
lib_ignore =
    DPrint,
    SimpleTimer,
    StatusLED,
    SettingsManager

[env:nodemcuv2]
platform = espressif8266
board = nodemcuv2
framework = arduino
monitor_speed = 115200
lib_deps =

lib_ignore =
    DPrint,
    SimpleTimer,
    StatusLED,
    SettingsManager
"@

    # .ino file content (Upgraded to use new helpers)
    $InoContent = @"
#include "config.h"       // Global settings (pins, debug flag, etc.)
#include "DPrint.h"       // Custom debug print library
#include "SimpleTimer.h"  // Non-blocking timer
#include "StatusLED.h"    // Status LED manager

// --- Global Objects ---
StatusLED statusLed(STATUS_LED_PIN);
SimpleTimer sensorTimer(SENSOR_READ_INTERVAL);

void setup() {
    // Initialize Debug Printing
    // This also calls Serial.begin(BAUD_RATE) if DEBUG_PRINT_ENABLED is true
    dprint.begin(BAUD_RATE, DEBUG_PRINT_ENABLED);
    dprint.println(F("--- Project $ProjectName Initialized ---"));
    dprint.printf("Chip ID: %lu\n", (unsigned long)ESP.getChipId()); // Example of printf

    // Set initial status LED mode
    statusLed.setMode(StatusLEDMode::HEARTBEAT);

    // Start timers
    sensorTimer.start();

    dprint.println(F("Setup complete."));
}

void loop() {
    // --- Must-call update functions ---
    // Call this in every loop to update the LED state
    statusLed.update();


    // --- Non-Blocking Tasks ---

    // Check if the sensor timer is finished
    if (sensorTimer.isFinished()) {
        dprint.println(F("Reading sensors..."));

        // Read your sensor here
        int sensorValue = analogRead(A0);
        dprint.printf("Sensor Value: %d\n", sensorValue);

        // Example: Change LED if value is high
        if (sensorValue > 800) {
            statusLed.setMode(StatusLEDMode::BLINK_FAST);
        } else {
            statusLed.setMode(StatusLEDMode::HEARTBEAT);
        }

        // Reset the timer for the next interval
        sensorTimer.reset();
    }

    // Your other non-blocking code here...
}
"@

    # README.md content (Upgraded)
    $ReadmeContent = @"
# $ProjectName

This is a new Arduino project scaffolded with an enhanced QOL helper set.

## Project Structure

- `src/`:
    - `$ProjectName.ino`: Main project sketch.
    - `config.h`: **Global project configuration**. Set pins, baud rates, and debug flags here.
- `lib/`:
    - `DPrint/`: Custom debug print library (with `printf` and template support).
    - `SimpleTimer/`: Helper class for non-blocking delays (replaces `delay()`).
    - `StatusLED/`: Helper class for managing a status/feedback LED.
    - `SettingsManager/`: Header-only template for saving/loading structs to EEPROM.
- `documentation/`: For project-specific documentation.
- `project_datasheets/`: For component datasheets.
- `images/`: For images used in documentation.
- `platformio.ini`: Configuration for PlatformIO (VS Code).
- `.gitignore`: Ignores common build files.

## Getting Started (PlatformIO - Recommended)

1.  Open this folder in Visual Studio Code with the **PlatformIO** extension installed.
2.  Open `platformio.ini` and **uncomment** the `[env:...]` section for your board (e.g., `[env:uno]`).
3.  Click the PlatformIO "Upload" button (right-arrow icon).

## Getting Started (Arduino IDE)

1.  Open the `$ProjectName.ino` file in the Arduino IDE.
2.  The IDE *should* automatically detect the libraries in the `lib/` folder.
3.  Upload the sketch to your board.

## Included QOL Libraries

### `config.h`
This is the central place to configure your project. **Modify this file first.**
- `DEBUG_PRINT_ENABLED`: Set to `true` or `false` to turn all `dprint` messages on or off.
- `BAUD_RATE`: Sets the serial monitor speed.
- `STATUS_LED_PIN`: Define which pin your status LED is on.

### `DPrint`
A powerful debug library. Use it instead of `Serial`.
- `dprint.begin(BAUD_RATE, DEBUG_PRINT_ENABLED)`: Call this in `setup()`.
- `dprint.print(message)`: Works with any data type.
- `dprint.println(message)`: Works with any data type.
- `dprint.printf("Value: %d\n", myVar)`: For C-style formatted strings.

### `SimpleTimer`
For non-blocking tasks.
```cpp
#include "SimpleTimer.h"
SimpleTimer myTimer(1000); // 1000ms interval

void setup() {
    myTimer.start();
}

void loop() {
    if (myTimer.isFinished()) {
        // Do something...
        myTimer.reset(); // Reset for next interval
    }
}
```

### `StatusLED`

Manage a feedback LED easily.

```cpp
#include "StatusLED.h"
StatusLED led(LED_BUILTIN);

void setup() {
    led.setMode(StatusLEDMode::HEARTBEAT); // I'm alive!
}

void loop() {
    led.update(); // MUST call this every loop
}
```

### `SettingsManager`

Save and load settings from EEPROM.

```cpp
#include "SettingsManager.h"

struct MyConfig { int val; };
SettingsManager<MyConfig> configManager;

void setup() {
    MyConfig cfg = configManager.load();
    cfg.val = 100;
    configManager.save(cfg);
}
```

"@
}

process {
    Write-Host "Scaffolding enhanced Arduino project: $ProjectName"

    # Create Project Root Directory
    if (-not (Test-Path -Path $ProjectRoot)) {
        if ($PSCmdlet.ShouldProcess($ProjectRoot, 'Create project root directory')) {
            Write-Host "Creating project root: $ProjectRoot"
            New-Item -ItemType Directory -Path $ProjectRoot | Out-Null
            Wait-Path -Path $ProjectRoot
        }
    } else {
        Write-Warning "Project directory '$ProjectRoot' already exists. Skipping creation."
        return # Exit if project directory already exists to prevent overwriting
    }

    # Change to project root for Git init and relative path creation
    Push-Location $ProjectRoot

    try {
        # Create Sub-directories first
        $FoldersToCreate = @(
            $SrcDir,
            $DocumentationDir,
            $ProjectDatasheetsDir,
            $ImagesDir,
            $LibDir
        )
        foreach ($folder in $FoldersToCreate) {
            if (-not (Test-Path -Path $folder)) {
                if ($PSCmdlet.ShouldProcess($folder, 'Create directory')) {
                    Write-Host "Creating directory: $folder"
                    New-Item -ItemType Directory -Path $folder | Out-Null
                    Wait-Path -Path $folder
                }
            }
        }

        # Git Initialization
        if (-not (Test-Path -Path '.git')) {
            if ($PSCmdlet.ShouldProcess('current directory', 'Initialize Git repository')) {
                Write-Host "Initializing Git repository..."
                git init | Out-Null
            }
        }
        else {
            Write-Warning "Git repository already exists in '$ProjectRoot'."
        }

        # --- Create Core Files ---

        # Create .gitignore
        if ($PSCmdlet.ShouldProcess('.gitignore', 'Create file with content')) {
            Write-Host "Creating .gitignore"
            Set-Content -Path '.gitignore' -Value $GitignoreContent
        }

        # Create platformio.ini
        if ($PSCmdlet.ShouldProcess('platformio.ini', 'Create file with content')) {
            Write-Host "Creating platformio.ini"
            Set-Content -Path 'platformio.ini' -Value $PlatformioIniContent
        }

        # Create README.md
        $ReadmePath = Join-Path $ProjectRoot 'README.md'
        if ($PSCmdlet.ShouldProcess($ReadmePath, 'Create README.md')) {
            Write-Host "Creating README.md"
            Set-Content -Path $ReadmePath -Value $ReadmeContent
        }

        # --- Create src/ Files ---

        # Create .ino file
        $InoFilePath = Join-Path $SrcDir "$ProjectName.ino"
        if ($PSCmdlet.ShouldProcess($InoFilePath, 'Create .ino file')) {
            Write-Host "Creating $ProjectName.ino"
            Set-Content -Path $InoFilePath -Value $InoContent
        }

        # Create config.h
        $ConfigHPath = Join-Path $SrcDir "config.h"
        if ($PSCmdlet.ShouldProcess($ConfigHPath, 'Create config.h')) {
            Write-Host "Creating config.h"
            Set-Content -Path $ConfigHPath -Value $ConfigHContent
        }

        # --- Create lib/ Files ---
        Copy-Item -Path $ScriptLibDir -Destination $LibDir -Recurse

        Write-Host "`nEnhanced Arduino project '$ProjectName' scaffolded successfully in '$ProjectRoot'."
        Write-Host "Run 'git add .' and 'git commit -m \"Initial project scaffold\"' to save changes."

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_"
        exit 1
    }
    finally {
        # Restore original ErrorActionPreference
        $ErrorActionPreference = $OriginalErrorActionPreference
        Pop-Location # Return to original directory
    }
}