# 📸 Screenshot Service

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
   git clone https://github.com/djware/R36S-apps
   ```
2. Make the Script Executable:
   ```
   Copy the file to the /opt/system/Tools/
   ```
3. Then run this command via SSH or telnet:
   ```
   chmod +x toggle_screenshot_service.sh
   ```   
4. Reboot device and then run the app after it appears in that location. It ill be under Options -> Tools. Depending on if it is enabled or disabled it will show the option.
![screenshot_2025-02-04_09-20-46](https://github.com/user-attachments/assets/bcea26b8-346a-4d29-9efe-0f9e2ff16977)

## 📷 Usage
Enable the Service: Run Enable Screenshot Service.sh.
Disable the Service: Run Disable Screenshot Service.sh.
Screenshots are saved in /roms/screenshots.

## 🛠️ Logs 
Log File: /roms/logs/screenshot_service.log

## 🖼️ Example
A demonstration of the LED sequence after a successful screenshot.
![screenshot_2025-02-04_09-20-46](https://github.com/user-attachments/assets/37439637-54ca-42a5-9b24-56df2bedd814)

![screenshot_2024-11-26_10-48-47](https://github.com/user-attachments/assets/c572e790-947f-437f-b8b5-f777116511d1)

![screenshot_2024-11-26_11-11-10](https://github.com/user-attachments/assets/da45eaf7-ec8d-4d05-901d-cac89b49fb07)

![screenshot_2024-11-26_14-01-11](https://github.com/user-attachments/assets/eb7266c7-9eef-411c-becb-7a69d7ebc370)

![screenshot_2024-11-26_14-13-25](https://github.com/user-attachments/assets/96f5afae-8726-4ebe-b90e-81d997e9a9ad)
