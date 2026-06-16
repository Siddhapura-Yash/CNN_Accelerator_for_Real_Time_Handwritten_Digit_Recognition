import serial
import sys

PORT = "/dev/ttyUSB0"   # Change as needed
BAUD = 1000000          # 1 Mbps
HEX_FILE = "my_img.hex"

# Read 784 hex values
with open(HEX_FILE, "r") as f:
    data = bytearray(
        int(line.strip(), 16)
        for line in f
        if line.strip()
    )

print(f"Loaded {len(data)} bytes")

if len(data) != 784:
    print(f"Warning: Expected 784 bytes, got {len(data)}")

with serial.Serial(PORT, BAUD, timeout=1) as ser:
    ser.reset_input_buffer()
    ser.reset_output_buffer()

    print("Sending...")
    ser.write(data)
    ser.flush()

print("Done")
