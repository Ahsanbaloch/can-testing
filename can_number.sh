#!/bin/bash

echo "Available CAN interfaces:"
ip link show | grep can

echo -e "\nActive CAN interfaces:"
ip -d link show up type can

active_count=$(ip -d link show up type can | grep -c "can")
echo -e "\nNumber of active CAN interfaces: $active_count"
