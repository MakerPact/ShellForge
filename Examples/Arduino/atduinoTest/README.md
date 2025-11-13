# atduinoTest

This is a new Arduino project scaffolded with an enhanced QOL helper set.

## Project Structure

- src/:
    - $ProjectName.ino: Main project sketch.
    - config.h: **Global project configuration**. Set pins, baud rates, and debug flags here.
- lib/:
    - DPrint/: Custom debug print library (with printf and template support).
    - SimpleTimer/: Helper class for non-blocking delays (replaces delay()).
    - StatusLED/: Helper class for managing a status/feedback LED.
    - SettingsManager/: Header-only template for saving/loading structs to EEPROM.
- documentation/: For project-specific documentation.
- project_datasheets/: For component datasheets.
- images/: For images used in documentation.
- platformio.ini: Configuration for PlatformIO (VS Code).
- .gitignore: Ignores common build files.

## Getting Started (PlatformIO - Recommended)

1.  Open this folder in Visual Studio Code with the **PlatformIO** extension installed.
2.  Open platformio.ini and **uncomment** the [env:...] section for your board (e.g., [env:uno]).
3.  Click the PlatformIO "Upload" button (right-arrow icon).

## Getting Started (Arduino IDE)

1.  Open the $ProjectName.ino file in the Arduino IDE.
2.  The IDE *should* automatically detect the libraries in the lib/ folder.
3.  Upload the sketch to your board.

## Included QOL Libraries

### config.h
This is the central place to configure your project. **Modify this file first.**
- DEBUG_PRINT_ENABLED: Set to 	rue or alse to turn all dprint messages on or off.
- BAUD_RATE: Sets the serial monitor speed.
- STATUS_LED_PIN: Define which pin your status LED is on.

### DPrint
A powerful debug library. Use it instead of Serial.
- dprint.begin(BAUD_RATE, DEBUG_PRINT_ENABLED): Call this in setup().
- dprint.print(message): Works with any data type.
- dprint.println(message): Works with any data type.
- dprint.printf("Value: %d\n", myVar): For C-style formatted strings.

### SimpleTimer
For non-blocking tasks.
`cpp
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
`

### StatusLED

Manage a feedback LED easily.

`cpp
#include "StatusLED.h"
StatusLED led(LED_BUILTIN);

void setup() {
    led.setMode(StatusLEDMode::HEARTBEAT); // I'm alive!
}

void loop() {
    led.update(); // MUST call this every loop
}
`

### SettingsManager

Save and load settings from EEPROM.

`cpp
#include "SettingsManager.h"

struct MyConfig { int val; };
SettingsManager<MyConfig> configManager;

void setup() {
    MyConfig cfg = configManager.load();
    cfg.val = 100;
    configManager.save(cfg);
}
`

