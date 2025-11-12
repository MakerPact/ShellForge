#Requires -Version 5.1
<#
.SYNOPSIS
    Scaffolds a new Arduino project with a custom debug print library.
.DESCRIPTION
    This script initializes a new project directory for an Arduino sketch.
    It performs the following actions:
    - Initializes a Git repository.
    - Creates a main .ino file with a pre-populated setup() and documentation for a custom debug print feature.
    - Creates a custom DPrint library (header and C++ files) that allows conditional serial printing.
    - Creates dedicated folders for documentation, project datasheets, and images.
    - Creates a .gitignore file with common Arduino and IDE ignores.
    - Creates a basic README.md for GitHub deployment.
.NOTES
    Author: Gemini
    Date: 2025-11-11
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory=$true, HelpMessage="The name of the Arduino project.")]
    [string]$ProjectName,

    [Parameter(HelpMessage="Enable or disable the custom debug print feature. Defaults to true.")]
    [bool]$EnableDebugPrint = $true
)

begin {
    # Set ErrorActionPreference to Stop to handle errors robustly
    $OriginalErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'

    # Define paths
    $ProjectRoot = Join-Path (Get-Location).ProviderPath $ProjectName
    $SrcDir = Join-Path $ProjectRoot 'src'
    $LibDir = Join-Path $ProjectRoot 'lib'
    $DPrintLibDir = Join-Path $LibDir 'DPrint'
    $DocumentationDir = Join-Path $ProjectRoot 'documentation'
    $ProjectDatasheetsDir = Join-Path $ProjectRoot 'project_datasheets'
    $ImagesDir = Join-Path $ProjectRoot 'images'

    # --- Content for files ---

    # .gitignore content
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
*.vscode/

# Libraries
/libraries/*
!/libraries/DPrint/ # Keep our custom library

# OS generated files
.DS_Store
Thumbs.db

# Project specific
.vscode/
.build/
.pio/
.idea/
'@

    # DPrint.h content
    $DPrintHContent = @'
#ifndef DPrint_h
#define DPrint_h

#include <Arduino.h>

class DPrint {
public:
    DPrint(bool enabled);
    void print(const char* message);
    void println(const char* message);
    void print(int value);
    void println(int value);
    void print(long value);
    void println(long value);
    void print(float value);
    void println(float value);
    void print(double value);
    void println(double value);
    void print(char value);
    void println(char value);
    void print(unsigned int value);
    void println(unsigned int value);
    void print(unsigned long value);
    void println(unsigned long value);
    void print(const String &value);
    void println(const String &value);

private:
    bool _enabled;
};

// Global instance for easy access, initialized in the .ino file
extern DPrint dprint;

#endif
'@

    # DPrint.cpp content
    $DPrintCppContent = @'
#include "DPrint.h"

DPrint::DPrint(bool enabled) : _enabled(enabled) {}

void DPrint::print(const char* message) {
    if (_enabled) {
        Serial.print(message);
    }
}

void DPrint::println(const char* message) {
    if (_enabled) {
        Serial.println(message);
    }
}

void DPrint::print(int value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(int value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(long value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(long value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(float value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(float value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(double value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(double value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(char value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(char value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(unsigned int value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(unsigned int value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(unsigned long value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(unsigned long value) {
    if (_enabled) {
        Serial.println(value);
    }
}

void DPrint::print(const String &value) {
    if (_enabled) {
        Serial.print(value);
    }
}

void DPrint::println(const String &value) {
    if (_enabled) {
        Serial.println(value);
    }
}
'@

    # .ino file content
    $InoContent = @"
#include <Arduino.h>
#include "DPrint.h"

// --- Debug Print Configuration ---
// Set to true to enable debug messages via dprint(), false to disable them.
const bool DEBUG_PRINT_ENABLED = $($EnableDebugPrint.ToString().ToLower());
DPrint dprint(DEBUG_PRINT_ENABLED); // Initialize the global DPrint instance

/*
 * DPrint Library Usage:
 *
 * The DPrint library provides a simple way to conditionally print debug messages
 * to the Serial monitor. When DEBUG_PRINT_ENABLED is true, calls to dprint.print()
 * and dprint.println() will output to Serial. When DEBUG_PRINT_ENABLED is false,
 * these calls will be ignored, effectively removing debug output without
 * needing to comment out lines of code.
 *
 * Example:
 *   void setup() {
 *     Serial.begin(115200);
 *     dprint.println("Setup started.");
 *   }
 *
 *   void loop() {
 *     static int counter = 0;
 *     dprint.print("Counter: ");
 *     dprint.println(counter++);
 *     delay(1000);
 *   }
 *
 * To disable debug printing, simply change 'const bool DEBUG_PRINT_ENABLED = true;'
 * to 'const bool DEBUG_PRINT_ENABLED = false;' at the top of this sketch.
 */

void setup() {
    Serial.begin(115200); // Initialize serial communication at 115200 baud
    dprint.println("Arduino project setup complete.");
    dprint.println("Welcome to your new project: $ProjectName");
}

void loop() {
    // Your main code goes here, to run repeatedly:
    dprint.println("Looping...");
    delay(1000);
}
"@

    # README.md content
    $ReadmeContent = @"
# $ProjectName

This is a new Arduino project scaffolded by ShellForge.

## Project Structure

- `src/`: Contains the main Arduino sketch (`.ino` file).
- `lib/DPrint/`: Custom debug print library.
- `documentation/`: For project-specific documentation.
- `project_datasheets/`: For component datasheets and technical specifications.
- `images/`: For images used in documentation or README.

## Getting Started

1.  Open the `$ProjectName.ino` file in the Arduino IDE or your preferred editor.
2.  Ensure the `DPrint` library is recognized (it's located in `lib/DPrint`).
3.  Upload the sketch to your Arduino board.
4.  Open the Serial Monitor (Baud Rate: 115200) to see debug output.

## Debug Printing with DPrint Library

This project includes a custom `DPrint` library to easily enable or disable debug messages.

To control debug output, modify the `DEBUG_PRINT_ENABLED` constant at the top of your `$ProjectName.ino` file:

````cpp
const bool DEBUG_PRINT_ENABLED = true; // Set to false to disable debug output
````

Use `dprint.print()` and `dprint.println()` just like `Serial.print()` and `Serial.println()`:

````cpp
dprint.println("This message will only appear if DEBUG_PRINT_ENABLED is true.");
dprint.print("Value: ");
dprint.println(someVariable);
````

## Contributing

Feel free to expand upon this project.

## License

This project is open-source. See the `LICENSE` file for more details.
"@
}

process {
    Write-Host "Scaffolding Arduino project: $ProjectName"

    # Create Project Root Directory
    if (-not (Test-Path -Path $ProjectRoot)) {
        if ($PSCmdlet.ShouldProcess($ProjectRoot, 'Create project root directory')) {
            Write-Host "Creating project root: $ProjectRoot"
            New-Item -ItemType Directory -Path $ProjectRoot | Out-Null
        }
    } else {
        Write-Warning "Project directory '$ProjectRoot' already exists. Skipping creation."
        return # Exit if project directory already exists to prevent overwriting
    }

    # Change to project root for Git init and relative path creation
    Push-Location $ProjectRoot

    try {
        # Create Sub-directories first to ensure they exist before files are written
        $FoldersToCreate = @(
            $SrcDir,
            $DPrintLibDir,
            $DocumentationDir,
            $ProjectDatasheetsDir,
            $ImagesDir
        )
        foreach ($folder in $FoldersToCreate) {
            if (-not (Test-Path -Path $folder)) {
                if ($PSCmdlet.ShouldProcess($folder, 'Create directory')) {
                    Write-Host "Creating directory: $folder"
                    New-Item -ItemType Directory -Path $folder | Out-Null
                    Start-Sleep -Milliseconds 100 # Add a small delay after creating each directory
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

        # Create .gitignore
        if ($PSCmdlet.ShouldProcess('.gitignore', 'Create file with content')) {
            Write-Host "Creating .gitignore"
            Set-Content -Path '.gitignore' -Value $GitignoreContent
        }

        # Create DPrint.h
        $DPrintHPath = Join-Path $DPrintLibDir 'DPrint.h'
        if ($PSCmdlet.ShouldProcess($DPrintHPath, 'Create DPrint.h')) {
            Write-Host "Creating DPrint.h"
            Set-Content -Path $DPrintHPath -Value $DPrintHContent
        }

        # Create DPrint.cpp
        $DPrintCppPath = Join-Path $DPrintLibDir 'DPrint.cpp'
        if ($PSCmdlet.ShouldProcess($DPrintCppPath, 'Create DPrint.cpp')) {
            Write-Host "Creating DPrint.cpp"
            Set-Content -Path $DPrintCppPath -Value $DPrintCppContent
        }

        # Create .ino file
        $InoFilePath = Join-Path $SrcDir "$ProjectName.ino"
        if ($PSCmdlet.ShouldProcess($InoFilePath, 'Create .ino file')) {
            Write-Host "Creating $ProjectName.ino"
            Set-Content -Path $InoFilePath -Value $InoContent
        }

        # Create README.md
        $ReadmePath = Join-Path $ProjectRoot 'README.md'
        if ($PSCmdlet.ShouldProcess($ReadmePath, 'Create README.md')) {
            Write-Host "Creating README.md"
            Set-Content -Path $ReadmePath -Value $ReadmeContent
        }

        Write-Host "`nArduino project '$ProjectName' scaffolded successfully in '$ProjectRoot'."
        Write-Host "Run 'git add .' and 'git commit -m \"Initial Arduino project scaffold\"' to save changes."

    }
    catch {
        Write-Error "An error occurred during project scaffolding: $_ "
    }
    finally {
        # Restore original ErrorActionPreference
        $ErrorActionPreference = $OriginalErrorActionPreference
        Pop-Location # Return to original directory
    }
}
