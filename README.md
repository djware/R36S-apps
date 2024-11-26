# 📸 Screenshot Service with LED Notifications

A simple, lightweight screenshot solution for arkOS with dynamic RGB LED feedback.

---

## ✨ Features

- **Capture Screenshots**: Press `L1` + `R1` to take a screenshot.
- **LED Feedback**: RGB LED flashes red → blue → red to confirm screenshot.
- **Automatic Saving**: Screenshots saved in `/roms/screenshots` with timestamps.
- **Toggle Service**: Easily enable or disable the screenshot service.
- **Logs**: Tracks actions and errors in `/roms/logs/screenshot_service.log`.

---

## 🚀 Installation

1. **Clone the Repository**:
   ```
   git clone https://github.com/yourusername/screenshot-service.git
   ```
2. Make the Script Executable:
   ```
   Copy the file to the /opt/system/Tools/
   chmod +x toggle_screenshot_service.sh
   ```
3. Reboot device and then run the app after it appears in that location.

📷 Usage
Enable the Service: Run Enable Screenshot Service.sh.
Disable the Service: Run Disable Screenshot Service.sh.
Screenshots are saved in /roms/screenshots.
