📸 Screenshot Service app
A lightweight yet powerful solution for capturing screenshots on your arkOS device with LED feedback! This project is designed to provide seamless screenshot functionality triggered by simultaneous button presses (L1 + R1), with vibrant LED indicators to confirm actions.

✨ Features
One-Touch Screenshot: Press L1 and R1 together to capture the screen instantly.
Dynamic LED Feedback: The RGB LED flashes in a sequence (Red → Blue → Red) to visually confirm a screenshot.
File Organization: Screenshots are automatically saved in /roms/screenshots with timestamped filenames.
Toggle Service: Easily enable or disable the screenshot service via the included toggle script.
Startup Integration: Runs automatically at boot when enabled.
Error Logging: Logs actions and errors to /roms/logs/screenshot_service.log for easy troubleshooting.
📂 File Structure
Here’s an overview of the files included in this project:

.
├── toggle_screenshot_service.sh         # Main toggle script to enable/disable the service
└── screenshot_with_led.service          # Systemd service for the screenshot app (auto-generated)
🚀 Getting Started
Prerequisites
Ensure your arkOS device meets the following requirements:

ffmpeg installed for capturing screenshots.
evtest installed for monitoring button presses.
Root access for managing GPIO pins and system services.
Installation
Clone the Repository:

git clone https://github.com/yourusername/screenshot-service.git
cd screenshot-service
Make the Toggle Script Executable:

chmod +x toggle_screenshot_service.sh
Run the Script to Enable the Service:

sudo ./toggle_screenshot_service.sh
The script will:

Create the screenshot capture script (/usr/local/bin/screenshot_with_led.sh).
Create a systemd service (/etc/systemd/system/screenshot_with_led.service).
Start and enable the service on boot.
📷 How It Works
Trigger Screenshot:

Simultaneously press the L1 and R1 buttons.
A screenshot of the framebuffer is captured and saved to /roms/screenshots.
Visual Confirmation:

The RGB LED flashes in a sequence:
Red: Starting the process.
Blue: Capturing the screenshot.
Red: Completion.
Log Actions:

All activities and errors are logged to /roms/logs/screenshot_service.log.
⚙️ Usage
Toggle the Service
Enable the Service: Run the script if it's named Enable Screenshot Service.sh:

sudo ./Enable\ Screenshot\ Service.sh
Disable the Service: Run the script if it's named Disable Screenshot Service.sh:

sudo ./Disable\ Screenshot\ Service.sh
View Logs
To check the log file for debugging:

cat /roms/logs/screenshot_service.log
🛠️ Troubleshooting
Script Not Working? Ensure the necessary dependencies (ffmpeg, evtest) are installed and your device has root access.

LED Not Flashing? Verify GPIO pins are configured correctly and have proper permissions.

Logs Not Showing Errors? Check /roms/logs/screenshot_service.log for detailed output and debugging information.

🖼️ Example
A demonstration of the LED sequence after a successful screenshot.
