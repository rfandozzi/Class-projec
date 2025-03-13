# File Guide for Feature Engineering Project

This branch contains all files related to the  `[feature-engineering]` branch. Below is a guide to the files and their purposes.

---

## Files and Descriptions

### **File: mnist-training.mat**

#### **Description:**
There are 2 key arrays in the file:

1. **`trainImages`**  
   - A 28 x 28 x 24000 three-dimensional array containing 24000 grayscale images.  
   - Each image is a 28 x 28 matrix with pixel values ranging between 0 and 1.

2. **`trainLabels`**  
   - A 24000 x 1 vector containing the corresponding labels for each image in `trainImages`.  
   - Each label is an integer in the set {0, 1, ... , 9}, representing the digit depicted in the image.

---

#### **Usage:**
1. **Load the Dataset:**
   ```matlab
   load('mnist-training.mat');

---

### **File: mnist-testing.mat**

#### **Description:**
There are 2 key arrays in the file:

1. **`testImages`**  
   - A 28 x 28 x 8000 three-dimensional array containing 8000 grayscale images.  
   - Each image is a 28 x 28 matrix with pixel values ranging between 0 and 1.

2. **`trainLabels`**  
   - A 8000 x 1 vector containing the corresponding labels for each image in `trainImages`.  
   - Each label is an integer in the set {0, 1, ... , 9}, representing the digit depicted in the image.

---

#### **Usage:**
1. **Load the Dataset:**
   ```matlab
   load('mnist-testing.mat');




### **File: part1.m**

#### **Description:**
This MATLAB script analyzes and classifies MNIST digit data through visualization, data reshaping, and a least-squares regression approach. The code explores differences in digit styles, reshapes image matrices into vectors, and uses random samples to compute weights for classification with varying accuracy.

---

#### **Key Features:**

1. **Digit Visualization (Part i):**
   - Loads MNIST data and generates 3x3 grids of sample images for each digit (0–9).
   - Uses `imagesc()` to visualize handwriting variations across digits.
   - Titles, labels, and grayscale colormap enhance interpretability.

2. **Image Reshaping (Part ii):**
   - Reshapes each 28 x 28 image matrix into a 784 x 1 column vector.
   - Stacks all vectors into a single matrix for further analysis.

3. **Least Squares Classification (Part iii):**
   - Randomly samples N images and computes weights w using the pseudoinverse to solve:
     \[
     \min_w \| X^T w - Y \|^2
     \]
   - Uses w to predict labels for the dataset and evaluates performance with:
     - A confusion matrix for error analysis.
     - Accuracy computation.
   - Explores how varying N affects classification accuracy.

---

#### **Usage:**
1. **Visualize Digits:**
   - Run the script to generate figures displaying digit variations across handwriting styles.
2. **Reshape Images:**
   - Converts MNIST image matrices into flattened vectors for easier computational handling.
3. **Classification:**
   - Adjust N (sample size) to observe its effect on accuracy.
   - Outputs a confusion matrix and accuracy score.

---

#### **Dependencies:**
- MATLAB environment.
- Input datasets: `trainImages`, `trainLabels`, `testImages`, `testLabels`.

---

#### **Outputs:**
- **Figures:** Displays 3x3 grids of digit samples (one figure per digit 0–9).
- **Confusion Matrix:** Assesses classification performance.
- **Accuracy:** Displays percentage of correctly classified digits.

---

#### **Additional Notes:**
- **Observations on Confusion Matrix:** Common misclassifications include:
  - \(7\) and \(2\)
  - \(8\) and \(4\)
  - \(3\) and \(2\)
- Increasing \(N\) improves accuracy, while decreasing \(N\) leads to reduced performance.

---
### **File: parttwo.m**

#### **Description:**
This MATLAB script performs feature extraction and binary classification for a specific digit class from the MNIST dataset. Using pixel frequency as a feature, it creates a simple decision boundary to classify images of a chosen digit (e.g., digit `0`) versus all other digits. The script also evaluates classification performance using a confusion matrix and accuracy metrics.

---

#### **Key Features:**

1. **Data Normalization:**
   - Applies z-score normalization to the MNIST dataset to standardize pixel intensity values.

2. **Feature Extraction:**
   - Analyzes the frequency of nonzero pixel values across samples of a target digit (`0`) to create a binary weight vector `wk`.
   - The binary weight vector highlights key pixels where the target digit typically appears.

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


