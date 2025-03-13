# File Guide for Photoresistor Wheel Speed Project and Fast Fourier Tranasform

This branch contains all files related to the  `[Python-photoresistor-wheel-speed-and-FFT]` branch. Below is a guide to the files and their purposes.

---

## Files and Descriptions

### **File: collect_data.py**

#### **Description:**
This Python script initializes the components then runs them and collects data to output to the data.txt file. 

---

#### **Key Features:**

1. **User arguments:**
   - The script uses argparse to collect user inputs while calling on the code.
   - The user can input the amount of time for the code to run, the delay between photoresistor measurements, if they want debug statements or not and the duty cycle desired for the motor. 

2. **Initialization:**
   - Initializes the Rasperry Pi and GPIO pins, the analog to digital converter, the photoresistor and the motor.
   - Calls on a function in mod7_funcs.py to initialize the motor and change its direction/duty cycle according to the user input.

3. **Writing to a file:**
   - Outputs all collected data to a file with two columns.
   - Each column has a header in the first row, the first column being time of the measurement and the second being the actual measurement in bits.

---

#### **Circuit Setup:**
Before running collect_data.py, ensure the circuit follows the schematic.png file and is wired as follows:

1. **Photoresistor:**
   - Connected to an MCP3008 ADC (Channel 0)
   - MCP3008 CVV to 3.3V, GND to GND, SPI to Rasperry Pi SPI pins.
     - MCP3008 pin 13 (CLK) = pin 23 on Rasperry Pi
     - MCP3008 pin 12 (MISO) = pin 21 on Rasperry Pi
     - MCP3008 pin 11 (MOSI) = pin 19 on Rasperry Pi
     - MCP3008 pin 10 (CS) = pin 24 on Rasperry Pi
---

2. **Motor (PWM Control):**
   - PWM Signal Output: GPIO
   - Includes using an H-Bridge in order to provide enough current (12V required compared to the 3.3V the          Rasperry Pi outputs) so that we can control the motor with a high power circuit from the input of the         low power Rasperry Pi
   - MCP3008 CVV to 3.3V, GND to GND, SPI to Rasperry Pi SPI pins.
   - For the H-Bridge:
     - PWM in1 = pin 33 on Rasperry Pi
     - PWM in2 = pin 35 on Rasperry Pi
     - PWM en  = pin 37 on Rasperry Pi
   - Must be connected to ground on Rasperry Pi
---

#### **Usage:**
1. **Collect data:**
   - Run the script to collect data for photoresistor values in order to then compute the speed of the wheel in the calculate_rpm.py script.
---

### **File: calculate_rpm.py**

#### **Description:**
This Python script reads the .txt file created from collect_data.py and calculates the rpm of the wheel spinning based on photoresistor data. The wheel is split into 4 alternating back and white quadrants from which the transitions are used to calculate the speed.

---

#### **Key Features:**

1. **Data Smoothing:**
   - Applies a 3 point moving average that wraps around the array so that each of the values in the array are    smoothed.

2. **Difference Calculation:**
   - The code calculates the difference between each of the measurements in order to normalize the data and      simplify it.
   - Based on this data, the algorithm identifies the largest value and minimum value using the NumPy library    in order to compute threshold values for the data to determine whether or not a transition from black to      white or vice vera was detected.
   - 

3. **Binary Classification:**
   - Implements a naive binary classifier:
     \[
     f_k(x) = w_k^T x
     \]
   - Uses the weight vector `wk` to classify images as either the target digit or not.
   - Defines a threshold based on the median value of `f_k(x)` for classification.

4. **Performance Evaluation:**
   - Computes a confusion matrix to assess:
     - True positives, false negatives, false positives, and true negatives.
   - Displays metrics for classification accuracy, false positive rate, and false negative rate.

---

#### **Usage:**
1. **Select a Digit Class:**
   - Modify the `num0` variable to target a specific digit (e.g., `trainLabels == 0` for digit `0`).

2. **Run the Script:**
   - Normalizes the dataset, extracts features, and classifies images.
   - Outputs classification metrics and a confusion matrix.

3. **Adjust Parameters:**
   - Tune the frequency threshold (`binary`) or classification threshold (`threshold`) to improve accuracy.

---

#### **Dependencies:**
- MATLAB environment.
- Input datasets: `trainImages`, `trainLabels`.

---

#### **Outputs:**
- **Classification Metrics:**
  - True positive, false negative, false positive, and true negative rates.
  - Overall accuracy as a percentage.
- **Confusion Matrix:**
  - Evaluates performance of the binary classifier for the chosen digit class.

---

#### **Additional Notes:**
- Using z-score normalization improved accuracy during preprocessing.
- Pixel frequency is used as a simple feature for classification but can be expanded with advanced transformations (e.g., edge detection or linear transformations).
- Observations:
  - Misclassifications depend on the choice of threshold and weight vector adjustments.
  - The model can be extended to include additional feature engineering techniques for improved performance.

 ---

 ### **File: digitClassifier.m**

#### **Description:**
This MATLAB script implements a multi-class classifier for handwritten digits (0–9) using MNIST data. The classifier uses a combination of feature extraction techniques, including pixel normalization, edge detection, and additional features like pixel intensity and frequency. It outputs the predicted digit label for a given image based on the highest scoring class.

---

#### **Key Features:**

1. **Preprocessing:**
   - **Normalization:** Normalizes input images using pre-computed means and standard deviations from the training set.
   - **Winsorization:** Caps outlier pixel values to fall within the range [-3, 3].
   
2. **Feature Extraction:**
   - **Edge Detection:** Uses the Sobel operator to compute horizontal and vertical edges, combining them to extract boundary features.
   - **Additional Features:**
     - **Pixel Intensity:** Average intensity across the image.
     - **Pixel Frequency:** Count of nonzero pixels in the image.

3. **Multi-Class Classification:**
   - Computes scores for each digit class (0–9) using a weighted features vector.
   - Predicts the digit with the highest score based on:
     \[
     \hat{f}(z) = \arg\max_{k=0,1,\dots,9} f_k(z)
     \]

---

#### **Usage:**
1. **Input:**
   - Requires `mnistmodel.mat` containing:
     - Pre-computed mean (`means`) and standard deviation (`std_dev`) for normalization.
     - Weight matrix (`w`) for classification.

2. **Function:**
   - Call the function `digitClassifier(z, w, means, std_dev)` with:
     - `z`: Input image (\(p \times p\) matrix).
     - `w`: Weight matrix for digit classification.
     - `means` and `std_dev`: Normalization parameters.

3. **Output:**
   - Returns the predicted label k in {0, 1, ... , 9}.

---

#### **Dependencies:**
- Requires the `mnistmodel.mat` file containing model parameters.
- Compatible with MNIST testing data for evaluation.

---

#### **Outputs:**
- **Predicted Label:** The digit classification for the given image.
- Can be tested against `mnist-testing.mat` to evaluate performance.

---

#### **Additional Notes:**
- **Edge Detection:** Sobel operator highlights key boundaries to enhance feature extraction.
- **Feature Vector:** Combines raw pixel values, edge information, and global features (intensity and frequency) for improved accuracy.
- **Classifier Performance:** Designed to generalize well to unseen MNIST test data.

---

## Additional Notes
- **Author:** Raynah Fandozzi
- **Date:** 12/5/2024
- **Contact:** @rfandozzi


