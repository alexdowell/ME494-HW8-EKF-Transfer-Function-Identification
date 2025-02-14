# ME494 HW8: EKF Transfer Function Identification  

## Description  
This repository contains the eighth homework assignment for **ME494**, focusing on system identification using an **Extended Kalman Filter (EKF)** and transfer function estimation. The assignment involves estimating system parameters for a **Mass-Spring-Damper (MSD) system**, modeling an **open-loop and closed-loop Quanser Qube system**, and analyzing flight test data for a small fixed-wing aircraft. The repository includes MATLAB scripts, datasets, and a PDF containing problem descriptions.  

## Files Included  

### **Part 1: Extended Kalman Filter for MSD System**  
- **File:** SID_HW8_1_2.m  
- **File:** msd_data_hw8.mat  
- **Topics Covered:**  
  - Implementing an **Extended Kalman Filter (EKF)**  
  - Estimating **damping coefficient, spring coefficient, and gravity constant**  
  - Evaluating convergence of parameter estimates  
  - Sensitivity analysis using different **Q and R matrix values**  

### **Part 2: Open-Loop System Identification for Quanser Qube**  
- **File:** SID_HW8_3.m  
- **File:** Qube_OpenLoop_HW8.mat  
- **Topics Covered:**  
  - Estimating a **transfer function model** from open-loop frequency sweep data  
  - Using **angular velocity and motor command input**  
  - Computing **model fit, frequency response, and Bode plots**  
  - Coherence analysis to assess model accuracy  

### **Part 3: Closed-Loop System Identification for Quanser Qube**  
- **File:** SID_HW8_4.m  
- **File:** Qube_ClosedLoop_HW8.mat  
- **Topics Covered:**  
  - Estimating a **discrete transfer function model** from closed-loop data  
  - Using **desired vs. actual angle measurements**  
  - Comparing **model fit and frequency response** with open-loop results  
  - Identifying cutoff frequency and analyzing phase shift  

### **Part 4: Aircraft System Identification from Flight Data**  
- **File:** SID_HW8_5.m  
- **File:** hw8_timber.mat  
- **Topics Covered:**  
  - Estimating a **transfer function for aircraft roll dynamics**  
  - Using **aileron deflection as input and roll rate as output**  
  - Applying **low-pass filtering to raw data**  
  - Bode plot analysis and coherence assessment  

### **Homework Assignment Document**  
- **File:** ME494HW8.pdf  
- **Contents:**  
  - Problem descriptions and equations  
  - MATLAB implementation steps  
  - Expected results and discussion points  

## Installation  
Ensure MATLAB is installed before running the scripts. No additional toolboxes are required.  

## Usage  

### **Running the Extended Kalman Filter for MSD System**  
1. Open MATLAB.  
2. Load `msd_data_hw8.mat` into the workspace.  
3. Run the script:  
   SID_HW8_1_2  
4. Observe estimated **position, velocity, acceleration, and system parameters** over time.  
5. Compare the effect of **Q and R matrix variations** on parameter convergence.  

### **Performing Open-Loop System Identification for Qube**  
1. Open MATLAB.  
2. Load `Qube_OpenLoop_HW8.mat` into the workspace.  
3. Run the script:  
   ```SID_HW8_3```  
4. View **transfer function model fit and frequency response plots**.  
5. Analyze **Bode plot coherence and cutoff frequency**.  

### **Performing Closed-Loop System Identification for Qube**  
1. Open MATLAB.  
2. Load `Qube_ClosedLoop_HW8.mat` into the workspace.  
3. Run the script:  
   ```SID_HW8_4```  
4. Compare **closed-loop model fit vs. open-loop results**.  
5. Analyze the **frequency response and coherence**.  

### **Estimating Aircraft Roll Dynamics from Flight Data**  
1. Open MATLAB.  
2. Load `hw8_timber.mat` into the workspace.  
3. Run the script:  
   ```SID_HW8_5```  
4. View **aileron input vs. roll rate output**.  
5. Analyze **transfer function fit, Bode plot, and coherence**.  

## Example Output  

- **EKF Parameter Estimation for MSD System**  
  - Estimated **damping coefficient, spring coefficient, and gravity constant**  
  - Comparison of parameter convergence under different **Q values**  

- **Quanser Qube Open-Loop System Identification**  
  - Transfer function model fit: **94.5%**  
  - Cutoff frequency: **10 rad/s**  
  - Phase shift observed at **100 rad/s**  

- **Quanser Qube Closed-Loop System Identification**  
  - Transfer function model fit: **94.84%**  
  - Cutoff frequency: **15 rad/s**  
  - Coherence remains strong up to **20 Hz**  

- **Aircraft System Identification Results**  
  - Estimated transfer function for **roll rate vs. aileron deflection**  
  - Model fit: **42.61%** (requires improvement)  
  - Bode plot analysis shows strong coherence between **0.5 Hz and 5 Hz**  

## Contributions  
This repository is intended for academic research and educational use. Contributions and modifications are welcome.  

## License  
This project is open for research and educational purposes.  

---  
**Author:** Alexander Dowell  

