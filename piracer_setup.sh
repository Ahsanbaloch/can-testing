#!/bin/bash

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Create and activate virtual environment
echo "Creating and activating virtual environment..."
python3 -m venv piracer_env || handle_error "Failed to create virtual environment"
source piracer_env/bin/activate || handle_error "Failed to activate virtual environment"

# Install required libraries
echo "Installing required libraries..."
pip install piracer-py || handle_error "Failed to install piracer-py"

# Set up CAN interface
echo "Setting up CAN interface..."
sudo ip link set can0 up type can bitrate 500000 || handle_error "Failed to set up CAN interface"

# Start candump in the background
echo "Starting candump..."
candump can0 &
CANDUMP_PID=$!

# Change permissions for InstrumentCluster
echo "Changing permissions for InstrumentCluster..."
chmod +x InstrumentCluster || handle_error "Failed to change permissions for InstrumentCluster"

# Run InstrumentCluster
echo "Running InstrumentCluster..."
./InstrumentCluster &
INSTRUMENT_CLUSTER_PID=$!

# Run the Python script
echo "Running the Python script..."
python3 - << EOF
from piracer.vehicles import PiRacerStandard
from piracer.gamepads import ShanWanGamepad

if __name__ == '__main__':
    shanwan_gamepad = ShanWanGamepad()
    piracer = PiRacerStandard()

    while True:
        gamepad_input = shanwan_gamepad.read_data()
        throttle = gamepad_input.analog_stick_right.y * 0.5
        steering = gamepad_input.analog_stick_left.x
        print(f'throttle={throttle}, steering={steering}')
        piracer.set_throttle_percent(throttle)
        piracer.set_steering_percent(steering)
EOF

# Clean up
kill $CANDUMP_PID
kill $INSTRUMENT_CLUSTER_PID
deactivate

echo "Script execution completed."
