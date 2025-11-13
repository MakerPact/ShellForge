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
    dprint.println(F("--- Project atduinoTest Initialized ---"));
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
