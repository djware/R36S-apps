#!/bin/bash

# Variables
SCRIPT_PATH="/usr/local/bin/screenshot_with_led.sh"
SERVICE_PATH="/etc/systemd/system/screenshot_with_led.service"
SCRIPT_NAME="toggle_screenshot_service.sh"
LOG_DIR="/roms/logs"
LOG_FILE="$LOG_DIR/screenshot_service.log"

# Create the log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    local MESSAGE="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $MESSAGE" | tee -a "$LOG_FILE"
}

# Content of the screenshot script
read -r -d '' SCRIPT_CONTENT << 'EOF'
#!/bin/bash

# Path to input event device
EVENT_DEVICE="/dev/input/event2"

# Path to save screenshots
SCREENSHOT_DIR="/roms/screenshots"

# GPIO pins for RGB LED
RED_PIN=77
GREEN_PIN=78
BLUE_PIN=79

# Ensure the screenshot directory exists
mkdir -p "$SCREENSHOT_DIR"

# Initialize key states
BTN_TL=0  # L1 button
BTN_TR=0  # R1 button

# Function to set up GPIO pins for LED
setup_gpio() {
    for pin in $RED_PIN $GREEN_PIN $BLUE_PIN; do
        echo $pin > /sys/class/gpio/export 2>/dev/null
        echo out > /sys/class/gpio/gpio$pin/direction
        chmod 777 /sys/class/gpio/gpio$pin/value
    done
}

# Function to set LED color
set_color() {
    echo $1 > /sys/class/gpio/gpio$RED_PIN/value
    echo $2 > /sys/class/gpio/gpio$GREEN_PIN/value
    echo $3 > /sys/class/gpio/gpio$BLUE_PIN/value
}

# Flash the LED to indicate a screenshot
flash_led() {
    # Red
    set_color 1 0 0
    sleep 0.1
    # Blue
    set_color 0 0 1
    sleep 0.1
    # Red again
    set_color 1 0 0
    sleep 0.1
    # Back to normal (off, off, off)
    set_color 0 0 0
}

# Function to take a screenshot
take_screenshot() {
    TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
    OUTPUT="$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
    if ffmpeg -y -f fbdev -i /dev/fb0 "$OUTPUT"; then
        echo "Screenshot saved to $OUTPUT"
    else
        echo "Failed to take screenshot"
    fi
    flash_led
}

# Set up the GPIO pins for the LED
setup_gpio

# Read the input event loop
while read -r line; do
    # Parse the event line
    if echo "$line" | grep -q "code 310 (BTN_TL)"; then
        BTN_TL=$(echo "$line" | grep -q "value 1" && echo 1 || echo 0)
    elif echo "$line" | grep -q "code 311 (BTN_TR)"; then
        BTN_TR=$(echo "$line" | grep -q "value 1" && echo 1 || echo 0)
    fi

    # Check if both buttons are pressed
    if [ "$BTN_TL" -eq 1 ] && [ "$BTN_TR" -eq 1 ]; then
        take_screenshot
        BTN_TL=0  # Reset states to prevent multiple triggers
        BTN_TR=0
    fi
done < <(sudo evtest "$EVENT_DEVICE" 2>/dev/null)
EOF

# Content of the systemd service
read -r -d '' SERVICE_CONTENT << EOF
[Unit]
Description=Screenshot with LED Listener
After=multi-user.target

[Service]
ExecStart=$SCRIPT_PATH
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Function to toggle the service
toggle_service() {
    if sudo systemctl is-enabled screenshot_with_led.service &>/dev/null; then
        log_message "Disabling Screenshot Service..."
        sudo systemctl stop screenshot_with_led.service 2>>"$LOG_FILE"
        sudo systemctl disable screenshot_with_led.service 2>>"$LOG_FILE"
        update_script_name "Enable Screenshot Service.sh"
    else
        log_message "Enabling Screenshot Service..."

        # Check if the script already exists
        if [ ! -f "$SCRIPT_PATH" ]; then
            echo "$SCRIPT_CONTENT" | sudo tee "$SCRIPT_PATH" > /dev/null
            sudo chmod +x "$SCRIPT_PATH"
            log_message "Created screenshot script at $SCRIPT_PATH"
        else
            log_message "Screenshot script already exists at $SCRIPT_PATH. Skipping creation."
        fi

        # Create the service
        echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_PATH" > /dev/null
        sudo systemctl daemon-reload 2>>"$LOG_FILE"
        sudo systemctl enable screenshot_with_led.service 2>>"$LOG_FILE"
        sudo systemctl start screenshot_with_led.service 2>>"$LOG_FILE"
        log_message "Service enabled and started"
        update_script_name "Disable Screenshot Service.sh"
    fi
}


# Function to update the script name
update_script_name() {
    NEW_NAME="$1"
    CURRENT_SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")  
    CURRENT_DIR=$(dirname "$CURRENT_SCRIPT")       
    CURRENT_NAME=$(basename "$CURRENT_SCRIPT")  

    if [ -f "$CURRENT_SCRIPT" ]; then
        mv "$CURRENT_SCRIPT" "$CURRENT_DIR/$NEW_NAME" 2>>"$LOG_FILE"
        log_message "Script renamed from $CURRENT_NAME to $NEW_NAME"
    else
        log_message "Script not found at $CURRENT_SCRIPT. Skipping renaming."
    fi
}


# Main Execution
log_message "Script execution started"
toggle_service
log_message "Script execution finished"
