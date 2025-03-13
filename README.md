# Class-projects
This repository contins a few projects in Python and MATLAB. 

## Python Projects
In Python, the projects are geared towards programming a car using a Rasperry Pi with inputs from a camera, photoresistor, accelerometer and ultrasonic senor using an analog to digital converter to come up with outputs for the servo motor and larger motor to actually power and steer the car. 

### **[Using photor resistor to determine wheelspeed (including Fast Fourier Transform for estimate): ](https://github.com/rfandozzi/Class-projects/tree/Python-photoresistor-wheels-peed-and-FFT)** A focusing on determining wheel speed of a motor given raw photoresistor data of a wheel split up into 4 black and white quadrants. The data was manipulated by taking a difference, determining the number of transitions then using that data to calculate RPM. This calculation was also verified by a FFT which was computed and graphed. 


## MATLAB Projects
In MATLAB, the projects are geared towards interpreting and drawing conclusions about large data sets, specifically with COVID 19 data sets and the MNSIT data set.

### **[K-means classiying:](https://github.com/rfandozzi/MATLAB-projects/tree/rfandozzi-k-means)** A case study aimed at successully clustering COVID data into different locations in order to predict the origin of the data.

### **[Dynamic systems modeling:](https://github.com/rfandozzi/MATLAB-projects/tree/rfandozzi-dynamic-systems-modeling)** This project uses the SIRD (succeptable-infectied-recovered-dead) model to simulate the spread of COVID-19. The goal was to tune model parameters and simulate real-world scenarios based on historical data.

### **[Feature engineering:](https://github.com/rfandozzi/MATLAB-projects/tree/feature-engineering)** This case study focuses on feature engineering digit images from the MNIST data set. This involved pplying a least-squares method to create an accurate weight vector for classification.

### **Neural networks:** Similar to feature enginerring, this project classifies MNIST digit images, but through the use of a neural network. It contrasts the feature engineering progect by automating the learning of features.
