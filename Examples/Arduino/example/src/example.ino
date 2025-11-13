#include <Arduino.h>
#include "DPrint.h"

// --- Debug Print Configuration ---
// Set to true to enable debug messages via dprint(), false to disable them.
const bool DEBUG_PRINT_ENABLED = true;
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
    dprint.println("Welcome to your new project: example");
}

void loop() {
    // Your main code goes here, to run repeatedly:
    dprint.println("Looping...");
    delay(1000);
}
