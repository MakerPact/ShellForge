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
