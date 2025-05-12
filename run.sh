#!/bin/bash
set -e

# Check for Qt installation
if ! command -v qmake6 &> /dev/null && ! command -v qmake &> /dev/null; then
    echo "Qt6 is not installed or not in PATH."
    echo "Please install Qt 6.4 or higher and ensure it is in your PATH."
    exit 1
fi

# Check if source directory exists
if [ ! -d "src" ]; then
    echo "Error: src directory not found. Make sure you're running this script from the project root."
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p build
cd build

# Run CMake
echo "Running CMake..."
cmake ..

# Build the application
echo "Building application..."
cmake --build . -j$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 2)

# Run the application
echo "Running application..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open ./HelloWorldApp.app
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    ./HelloWorldApp
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    # Windows
    ./HelloWorldApp.exe
else
    echo "Unknown operating system. Please run the executable manually."
fi
