# can-testing

## can-number.sh

can-number.sh
This script performs the following functions:
- It displays a list of all available CAN (Controller Area Network) interfaces on the system, regardless of their status.
- It then shows only the active CAN interfaces, providing more detailed information about these enabled interfaces.
- Finally, it counts and reports the number of active CAN interfaces.
The script uses the ip command to gather information about network interfaces, specifically filtering for CAN interfaces. It provides a quick overview of the CAN network setup on the system, which is useful for diagnostics and system configuration checks in automotive or industrial network environments.


# PiRacer Setup Script

## Description

`piracer-setup.sh` is a comprehensive Bash script that automates the setup and execution of a complete PiRacer environment. This script integrates multiple components for seamless operation of the PiRacer system.

## Features

- Sets up a Python virtual environment
- Configures CAN (Controller Area Network) interface
- Initializes the Instrument Cluster GUI
- Runs PiRacer control script for steering and throttle
- Handles errors and performs cleanup on exit

## Prerequisites

- Linux-based system (preferably Raspberry Pi)
- Python 3
- CAN utilities (`can-utils` package)
- Qt environment for Instrument Cluster GUI

## Script Overview

The script performs the following operations:

1. **Environment Setup**:
- Creates and activates a Python virtual environment
- Installs required libraries (e.g., piracer-py)

2. **CAN Interface Configuration**:
- Sets up and configures the CAN interface
- Starts `candump` for CAN bus monitoring

3. **Instrument Cluster Initialization**:
- Prepares and executes the InstrumentCluster application

4. **PiRacer Control**:
- Runs a Python script for:
  - Gamepad input processing
  - PiRacer throttle and steering control

5. **Error Handling and Cleanup**:
- Implements error handling for robustness
- Ensures proper cleanup of processes on exit

