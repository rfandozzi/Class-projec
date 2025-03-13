# File Guide for Dynamic Systems Modeling Project

This document provides an overview of the files in the `[rfandozzi-dynamic-systems-modeling]` branch.

---

## Files and Descriptions

### **File: COVID_STL (1).mat**

#### **Description:**
There are 4 key arrays in the file:

1. **`cases_STL`**  
   - A 1 x 158 vector containing cumulative COVID-19 cases for St. Louis city and county over time.

2. **`deaths_STL`**  
   - A 1 x 158 vector containing cumulative COVID-19 deaths for St. Louis city and county over time.

3. **`dates`**  
   - A 1 x 158 vector where each entry corresponds to the date of the respective entries in `cases_STL` and `deaths_STL`.

4. **`POP_STL`**  
   - A scalar value representing the total population of St. Louis city and county.

---

#### **Usage:** 
- Load this file in MATLAB using:
  ```matlab
  load('COVID_STL (1).mat');


---

### **File: mockdata (1).mat**

#### **Description:**
There are 2 key arrays in the file:

1. **`cumulativeDeaths`**  
   - A 1 x 400 vector representing the cumulative fraction of the population that has died due to the disease over 400 days.

2. **`newInfections`**  
   - A 1 x 400 vector representing the fraction of the population that became newly infected each day.

---

#### **Usage:**
- Load the file into MATLAB:
  ```matlab
  load('mockdata.mat');




### **File: part1-1.m**

#### **Description:**
This project involves simulating and analyzing a discrete-time dynamical model based on the SIRD (susceptible infected recovered dead) framework, with extensions to include re-infections. The tasks explore custom model implementation, parameter sensitivity, and comparisons with MATLAB's built-in functions. Key aspects of the project include:

---

#### **Key Steps:**

1. **Simulate the Model from Scratch:**
   - Implements the SIRD model using matrix and vector operations, avoiding excessive use of loops.
   - Explores how varying model parameters affects the output dynamics.
   - Produces plots to observe how the system converges over time, mirroring examples from reference literature.

2. **Modify the Model for Re-Infections:**
   - Extends the base SIRD model to include scenarios where recovered individuals can become susceptible again.
   - Simulates the modified model and produces plots to analyze the impact of re-infections.

3. **Analyze the `base sir.m` Script:**
   - Explores the MATLAB `ss` and `lsim` functions for simulating linear dynamical systems.
   - Examines the discrete-time implementation and the role of state matrix `A` in the model setup.
   - Compares outputs from the custom simulation (from scratch) with those from `lsim`-based simulations.

4. **Document Results:**
   - Compares and contrasts the performance of from-scratch and built-in implementations.


---


#### **Outputs:**
- Figures illustrating:
  - Parameter sensitivity in the SIRD model.
  - Effects of re-infections on model dynamics.
  - Comparison between custom and `lsim`-based implementations.

---


### **File: part2.m**

#### **Description:**
This MATLAB script models and analyzes the propagation dynamics of COVID-19 during the Delta and Omicron waves in St. Louis city and county. It optimizes transition matrices for the SIRD model to fit real data and compares the dynamics of the two phases.

---

#### **Key Features:**
- **Delta Wave Analysis:**  
  - Optimizes the transition matrix \(A\) to minimize the error between model and real data for cases and deaths.
  - Visualizes modeled and real data dynamics during the Delta phase.
  
- **Omicron Wave Analysis:**  
  - Similar optimization and visualization as the Delta wave, adjusted for Omicron data.
  
- **Comparison Across Waves:**  
  - Highlights differences in viral propagation and models the impact of varying transmission parameters.

---

#### **Usage:**
1. **Input Data:** Requires `COVID_STL.mat` containing cumulative cases, deaths, and population data.
2. **Run Script:** Adjust initial guesses and bounds for \(A\) matrix as needed.
3. **Output:** Plots comparing modeled vs. real cases and deaths for each phase.

---

#### **Dependencies:**
- MATLAB Optimization Toolbox (for `fmincon`).
- `COVID_STL.mat` dataset.

---

#### **Output:**
- Optimized transition matrices for Delta and Omicron phases.
- Comparative plots of real vs. modeled dynamics.


---

### **File: part3.m**

#### **Description:**
This MATLAB script models the dynamics of a population experiencing the rollout of vaccines and breakthrough infections over time. Using mock data (`mockdata.mat`), the script augments a base SIRD model to include vaccination as a state variable and estimates key metrics such as vaccination and breakthrough infection rates.

---

#### **Key Features:**
1. **Pre-Vaccine Dynamics:**
   - Simulates population dynamics before vaccine rollout (days 1–125) using a state transition matrix.

2. **Post-Vaccine Dynamics:**
   - Incorporates vaccination as a state variable and simulates population behavior after day 125.
   - Adds breakthrough infections to the model with appropriate transition rates.

3. **Parameter Estimation:**
   - Estimates the vaccination rate and breakthrough infection rate from the augmented model.
   - Compares model-predicted new cases and deaths to the real data.

4. **Visualization:**
   - Plots model outputs (deaths and new cases) against real data for comparison.

---

#### **Usage:**
1. **Input Data:**
   - Load `mockdata.mat`, which contains cumulative deaths and new infections over 400 days.

2. **Run Script:**
   - Adjust transition matrices `A1` (pre-vaccine) and `A2` (post-vaccine) for specific scenarios.
   - Execute the script to simulate population dynamics and compute metrics.

3. **Output:**
   - Estimated vaccination and breakthrough infection rates.
   - Comparative plots of model and real data.

---

#### **Dependencies:**
- MATLAB environment.
- Input file `mockdata.mat`.

---

#### **Outputs:**
- Vaccination rate and breakthrough rate estimates displayed in the command window.
- Comparative plots showing:
  - Modeled vs. real deaths.
  - Modeled vs. real new infections.
  - Total population dynamics across all states.

---

### **File: Case_Study_2 (3) (2).pdf**
- **Description:** Detailed writeup for the project. Explains the objectives, methods, and results.
- **Format:** PDF


## Additional Notes
- **Author:** Raynah Fandozzi
- **Date:** 12/5/2024
- **Contact:** @rfandozzi
