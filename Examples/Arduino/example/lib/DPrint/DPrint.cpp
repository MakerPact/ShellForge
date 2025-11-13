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
