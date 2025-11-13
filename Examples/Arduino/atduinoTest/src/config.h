#ifndef config_h
#define config_h

#include <Arduino.h>

// --- Debug & Serial ---
// Set to true to enable debug messages, false to disable.
const bool DEBUG_PRINT_ENABLED = true;
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
