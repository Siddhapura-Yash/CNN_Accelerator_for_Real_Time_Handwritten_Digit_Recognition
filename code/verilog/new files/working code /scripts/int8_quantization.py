"""
quantize_and_export.py
Updated for 0-255 Training & Verilog Compatibility
"""

import torch
import numpy as np
import os

# Configuration
PTH_PATH    = "cnn_mnist_weights.pth"
OUTPUT_DIR  = "." 

def quantize_symmetric_int8(tensor: torch.Tensor, name: str) -> np.ndarray:
    """
    Per-tensor symmetric INT8 quantization.
    We map the maximum absolute value in the weights to 127.
    """
    max_val = tensor.abs().max().item()
    if max_val == 0:
        return np.zeros(tensor.shape, dtype=np.int8)
    
    scale = 127.0 / max_val
    print(f"  Layer: {name:15} | Scale Factor: {scale:.4f} (1/Scale: {1/scale:.6f})")
    
    # Scale, round, and clamp to fit in 8-bit signed range [-128, 127]
    q = torch.round(tensor * scale).clamp(-128, 127).to(torch.int8)
    return q.numpy()

def write_mem(filename: str, data: np.ndarray):
    """
    Writes data to a .mem file in Hex format for Verilog $readmemh.
    """
    path = os.path.join(OUTPUT_DIR, filename)
    # Cast the entire array to uint8 to handle two's complement hex conversion
    unsigned_data = data.astype(np.uint8).flatten()
    
    with open(path, "w") as f:
        for val in unsigned_data:
            # Now 'val' is 0-255, so format works perfectly
            f.write(f"{val:02X}\n")
    print(f"  Saved {len(unsigned_data):>6} values to {filename}")

def main():
    if not os.path.exists(PTH_PATH):
        print(f"Error: {PTH_PATH} not found!")
        return

    print(f"Loading weights from {PTH_PATH}...")
    state = torch.load(PTH_PATH, map_location="cpu")
    if "state_dict" in state:
        state = state["state_dict"]

    print("\nQuantizing weights to INT8...")
    
    # 1. Conv1 Weights: [16, 1, 3, 3] -> 16 kernels of 3x3
    conv1_w = quantize_symmetric_int8(state["conv1.weight"], "Conv1 Weights")
    # Flatten to [144] (16 * 3 * 3)
    conv1_w_flat = conv1_w.reshape(16, 9) 

    # 2. Conv1 Bias: [16]
    conv1_b = quantize_symmetric_int8(state["conv1.bias"], "Conv1 Bias")

    # 3. FC Weights: [10, 2704]
    # Note: 2704 comes from 16 channels * 13 * 13
    fc_w = quantize_symmetric_int8(state["fc.weight"], "FC Weights")

    # 4. FC Bias: [10]
    fc_b = quantize_symmetric_int8(state["fc.bias"], "FC Bias")

    print("\nWriting Verilog .mem files...")
    write_mem("conv1_kernels.mem", conv1_w_flat)
    write_mem("conv1_biases.mem",  conv1_b)
    write_mem("fc_weights.mem",    fc_w)
    write_mem("fc_biases.mem",     fc_b)

    # Verilog Integration Tips
    print("\n" + "="*30)
    print("VERILOG INTEGRATION TIPS:")
    print("1. Pixels: Ensure your Verilog testbench feeds pixels as 8-bit [0-255].")
    print("2. Accumulators: Use 32-bit signed regs for sums before ReLU.")
    print("3. Scaling: Since you quantized weights, your final output will be")
    print("   scaled by (1/WeightScale). Since we are just looking for the")
    print("   MAX (Argmax) for classification, the absolute scale doesn't matter!")
    print("="*30)

if __name__ == "__main__":
    main()