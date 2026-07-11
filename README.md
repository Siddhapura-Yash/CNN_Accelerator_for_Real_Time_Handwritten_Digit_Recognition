# CNN Accelerator for Real-Time Handwritten Digit Recognition

## Overview

This project implements a cnn accelerator in verilog for real-time handwritten digit recognition on fpga. image data is received through uart, processed entirely in hardware, and the predicted digit is displayed on a seven-segment display.

Honestly, i did this project mainly because i just wanted to see if i could build a working fpga-based cnn from scratch and actually verify it in hardware. the design totally works and gets the job done, but i'll be the first to admit it is definitely not fully optimized right now. my main goal was just to get the math, memory, and data flow functioning properly as a proof of concept. i will definitely be optimizing the pipeline, reducing memory usage, and improving the timing in the future once i have more time!

---

## Project Highlights

* **verilog-based cnn accelerator**
* **streaming image processing architecture**
* **16 parallel MAC units for convolution**
* **INT8 quantized weights and biases**
* **UART image transfer from host PC**

---

## Architecture

i've made this block diagram kind of thing based on what i understood about the overall data flow and connections while building the system:


<p align="center">
  <img src="doc/images/architecture.png" width="900">
</p>

---

## How It Works (The Hardware Pipeline)

i've really tried my best to explain how a cnn actually works down below, especially if you are just getting started with hardware machine learning. it can be a bit confusing at first, so here is a step-by-step breakdown of how this digital brain actually processes an image.

### Training vs. Inference

first off, it is important to note this project performs **inference**, not training. training is the heavy lifting you do on a big gpu using python to find the perfect "weights" and "biases". we take those pre-trained, locked-in numbers from python and load them straight into the fpga's memory (BRAM). the hardware just uses those fixed numbers to evaluate new, unseen images in real-time.

### 1. Convolution Layer (Extracting Features)

think of convolution like a tiny 3x3 digital magnifying glass (called a kernel) that slides across our 28x28 input image pixel by pixel.

* at each step, the hardware multiplies 9 image pixels by 9 kernel weights, adds them all up together, and then adds a single bias value to that sum.
* we use 16 different kernels in this design, meaning the chip is simultaneously looking for 16 different shapes (like vertical edges, horizontal lines, or corners).
* umm, because a 3x3 kernel naturally cuts off the very edges of an image when it slides across, our 28x28 image gets shrunk slightly and is converted into 16 separate 26x26 "feature maps".

### 2. ReLU Activation (Cleaning the Noise)

if we only used standard multiplication and addition, the network would just be a massive flat line and wouldn't be able to learn complex, curvy shapes. ReLU is basically a super simple filter we use to fix this:

* if a calculated pixel value is positive, we keep it exactly as it is.
* if it is negative, we just force it to 0.
* this step easily cleans up useless background noise and negative signals using very minimal hardware logic blocks.

### 3. Max-Pooling Layer (Shrinking the Data)

having sixteen 26x26 images is a ton of data to move around on the chip. to save logic blocks and make the whole architecture run much faster, we use a 2x2 max-pooling filter. it looks at a small 2x2 square of pixels and only keeps the single largest number, completely throwing the other three away. this shrinks our feature maps down to a much more manageable 13x13 size while keeping the most important, boldest features completely intact.

### 4. Dense Layer (The Jury)

now we take all those remaining features (which flatten out to 2,704 total values) and pass them to a fully connected dense layer. we have 10 output classes representing the digits 0 through 9. this layer calculates a final confidence score for each of the 10 digits based on all the extracted clues it received from the previous layers.

### 5. Argmax (The Final Verdict)

once we have the 10 final scores sitting in our registers, the Argmax block simply runs a quick set of comparators across them and picks the highest one. if the score for the "3" register is the highest, the fpga confidently outputs a "3" to the display!

### Learning More

i tried to break it down simply here, but if you want to understand the math and theory deeply, i would highly suggest watching the neural networks playlist by 3blue1brown. it is incredibly visual and makes the whole concept click so easily. you can check it out here:
[3Blue1Brown - Neural Networks Playlist](https://youtube.com/playlist?list=PLZHQObOWTQDNU6R1_67000Dx_ZCJB-3pi&si=7mNPJ469yJ2Wg15Y)

---

## Project Structure

```text
CNN-Accelerator-for-Real-Time-Handwritten-Digit-Recognition
│
├── rtl/
├── parameter/
├── simulation/
├── uart example/
├── python/
└── README.md
```

---

## Output Demonstration
<p align="center">
  <img src="doc/images/result.gif" width="500">
</p>

**YouTube Demo**: [https://youtube.com/shorts/lP0CcqOGTO4?si=nFGsThKfcxfNwQfs] <br>
**Blog** : https://medium.com/@siddhapurayash09/how-i-built-a-cnn-accelerator-on-fpga-using-verilog-32bb0fd3b450

---

## Resource Utilization

The design was implemented on the Efinix Ti375 FPGA and uses approximately:

* **12,353 Logic Elements** (~3.8%)
* **100 Memory Blocks** (~3.7%)
* **137 DSP Blocks** (~10.2%)

The design has been successfully synthesized and can operate at frequencies up to **100 MHz**.

---

## Performance

* **Maximum Operating Frequency:** 100 MHz
* **Parallel Compute Units:** 16 INT8 MACs
* **Peak Compute Throughput:** **3.2 GOPS (0.0032 TOPS)**

**Calculation:**

* 16 parallel MACs
* 1 MAC = 1 Multiply + 1 Add = **2 operations**
* Operations per clock = **16 × 2 = 32**
* Clock frequency = **100 MHz = 100 × 10⁶ cycles/second**

```text
Operations/second = 32 × 100 × 10⁶
                  = 3.2 × 10⁹

Peak Throughput = 3.2 GOPS = 0.0032 TOPS
```

> **Note:** The convolution and fully connected layers use separate MAC hardware but execute sequentially rather than simultaneously. Therefore, the reported throughput represents the peak performance of the active compute engine at any given time.

---

## License

This project is released under the MIT License.



