# File Guide for K-Means Project

This branch contains all files related to the  `[rfandozzi-k-means]` branch. Below is a guide to the files and their purposes.

---

## Files and Descriptions

### **File: COVIDbyCounty (1).mat**

#### **Description:** 
There are 3 key arrays in the file:
1. **CNTY_COVID**  
   - An `m × n` matrix, where `m` is the number of counties and `n` is the number of dates.  
   - Each entry represents the new COVID-19 cases in a county per week, normalized by 100k population.

2. **CNTY_CENSUS**  
   - A table with `m` rows corresponding to counties in the `CNTY_COVID` matrix.  
   - Columns provide summary census data, including:
     - FIPS code
     - Division code
     - Division name
     - State name
     - County name
     - Estimated population (2021).

3. **dates**  
   - A `1 × n` vector containing dates that correspond to the columns in the `CNTY_COVID` matrix.
#### **Usage:** 
- Load this file in MATLAB using:
  ```matlab
  load('COVIDbyCounty (1).mat');


---
### **File: cluster_covid_data-1.m**

#### **Description:**
This script performs clustering on COVID-19 case data to identify patterns and associate counties with census divisions. The clustering process involves preprocessing, k-means clustering, and mapping clusters to divisions.

---

#### **Key Steps:**
1. **Load and Preprocess Data:**
   - Smooths the COVID-19 data using a moving average.
   - Normalizes the data (z-score normalization).
   - Calculates COVID-19 rate data (change in cases over time).

2. **Split Data into Training and Testing Sets:**
   - Separates data into training (80%) and testing (20%) based on state-level grouping.

3. **Cluster Data Using K-Means:**
   - Applies k-means clustering to the training data (`trimmedCovid`) and COVID rate data (`covidRate`) with 22 clusters.
   - Maps clusters to census divisions based on the majority presence of divisions in each cluster.

4. **Save Results for Classification:**
   - Saves centroids, cluster labels, and additional mapping data for later use in classification.

---

#### **Usage:**
- Run the script to:
  - Preprocess COVID data.
  - Cluster counties into groups.
  - Map clusters to census divisions.
  - Save clustering results for testing with classification.

---

#### **Dependencies:**
- Requires `COVIDbyCounty.mat` as input.

---

#### **Outputs:**
- `competition.mat`: Contains centroids and cluster labels.
- `extraForClassify.mat`: Contains division-to-cluster mappings and testing data mappings.

---

### **File: classify_covid_data-.m**

#### **Description:**
This script evaluates the accuracy of the clustering model by assigning testing data to the nearest cluster centroids and comparing the results to the actual census division labels.

---

#### **Key Steps:**
1. **Load Data:**
   - Loads the saved clustering data (`competition.mat` and `extraForClassify.mat`) and the original COVID dataset.

2. **Assign Testing Data to Clusters:**
   - Calculates the cosine distance between testing data and centroids.
   - Assigns each county in the testing set to the closest centroid.

3. **Determine Census Divisions for Testing Data:**
   - Maps the assigned clusters to the most likely census divisions using the division-to-cluster mappings (`divtoClusterReal` and `divtoClusterRateReal`).

4. **Evaluate Model Accuracy:**
   - Compares the predicted divisions with the actual divisions in the testing dataset.
   - Calculates the testing accuracy rate and displays it.

---

#### **Usage:**
- Run the script to:
  - Assign testing data to clusters.
  - Predict census divisions for each county.
  - Evaluate the clustering model's accuracy.

---

#### **Dependencies:**
- Requires:
  - `COVIDbyCounty.mat`: Original dataset.
  - `competition.mat`: Cluster centroids and labels.
  - `extraForClassify.mat`: Division-to-cluster mappings.

---

#### **Outputs:**
- Displays the accuracy rate of the clustering model for the testing data.

---

### **File: case study 1 report.pdf**
- **Description:** Detailed writeup for the project. Explains the objectives, methods, and results.
- **Format:** PDF

---

## Additional Notes
- **Author:** Raynah Fandozzi
- **Date:** 12/5/2024
- **Contact:** @rfandozzi


