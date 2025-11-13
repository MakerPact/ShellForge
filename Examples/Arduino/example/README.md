# example

This is a new Arduino project scaffolded by ShellForge.

## Project Structure

- src/: Contains the main Arduino sketch (.ino file).
- lib/DPrint/: Custom debug print library.
- documentation/: For project-specific documentation.
- project_datasheets/: For component datasheets and technical specifications.
- images/: For images used in documentation or README.

## Getting Started

1.  Open the $ProjectName.ino file in the Arduino IDE or your preferred editor.
2.  Ensure the DPrint library is recognized (it's located in lib/DPrint).
3.  Upload the sketch to your Arduino board.
4.  Open the Serial Monitor (Baud Rate: 115200) to see debug output.

## Debug Printing with DPrint Library

This project includes a custom DPrint library to easily enable or disable debug messages.

To control debug output, modify the DEBUG_PRINT_ENABLED constant at the top of your $ProjectName.ino file:

``cpp
const bool DEBUG_PRINT_ENABLED = true; // Set to false to disable debug output
``

Use dprint.print() and dprint.println() just like Serial.print() and Serial.println():

``cpp
dprint.println("This message will only appear if DEBUG_PRINT_ENABLED is true.");
dprint.print("Value: ");
dprint.println(someVariable);
``

## Contributing

Feel free to expand upon this project.

## License

This project is open-source. See the LICENSE file for more details.
