#!/bin/bash

# 256 Color Grid Display Script
# This script displays all 256 terminal colors in a organized grid format

echo "256 Terminal Colors Grid"
echo "========================"
echo

# Standard colors (0-15)
echo "Standard Colors (0-15):"
for i in {0..15}; do
    printf "\e[48;5;${i}m %3d \e[0m" $i
    if [ $((($i + 1) % 8)) -eq 0 ]; then
        echo
    fi
done
echo
echo

# 216 color cube (16-231)
echo "Color Cube (16-231):"
for i in {16..231}; do
    printf "\e[48;5;${i}m %3d \e[0m" $i
    if [ $(((($i - 16) + 1) % 6)) -eq 0 ]; then
        printf " "
    fi
    if [ $(((($i - 16) + 1) % 36)) -eq 0 ]; then
        echo
    fi
done
echo
echo

# Grayscale ramp (232-255)
echo "Grayscale Ramp (232-255):"
for i in {232..255}; do
    printf "\e[48;5;${i}m %3d \e[0m" $i
    if [ $((($i + 1) % 8)) -eq 0 ]; then
        echo
    fi
done
echo
echo

# Show colors with text for readability test
echo "Sample text on different backgrounds:"
echo "====================================="
for i in {0..15}; do
    printf "\e[48;5;${i}m\e[97m Color %3d \e[0m " $i
    printf "\e[48;5;${i}m\e[30m Color %3d \e[0m " $i
    if [ $((($i + 1) % 4)) -eq 0 ]; then
        echo
    fi
done
echo

echo "Script completed! Your terminal supports 256 colors if you see distinct colors above."
