# **Predicting Incident Resolution Time App**

### **Mission:**
The goal of this application is to predict the time it takes to resolve cybersecurity incidents based on historical threat data. By doing so, organizations can:

- **Assess incident resolution efficiency**
- **Optimize resource allocation** for incident handling
- **Anticipate future cybersecurity challenges**
- **Enhance response strategies** through data-driven insights

---

### **Demo Video:**
[Watch the demo video](https://youtu.be/YkvAF2gqAXw)

---

### **Dataset Description:**

**Source:** [Global Cybersecurity Threats (2015-2024) Dataset on Kaggle](https://www.kaggle.com/datasets/atharvasoundankar/global-cybersecurity-threats-2015-2024)

This dataset contains information about cybersecurity incidents with several key features that can be used to predict incident resolution times.

#### **Key Features:**
- **Threat Type:** Type of cybersecurity threat
- **Incident Category:** Category of the incident (e.g., Phishing, Ransomware, etc.)
- **Year:** Year of the incident (2015-2024)
- **Incident Duration:** Time taken to resolve the incident (target variable)
- **Incident Severity:** Severity level of the incident (scale)
- **Response Time:** Initial response time to the incident
- **Resources Allocated:** Resources used to resolve the incident

---

### **Analysis Objectives:**

- **Analyze the factors** that affect cybersecurity incident resolution times.
- **Build predictive models** to estimate the resolution time for future incidents.
- **Assist organizations** in improving their incident response strategies and efficiency.

---

### **API Endpoints:**

- **Prediction Endpoint (POST):** (https://linear-regression-model-lp6t.onrender.com/predict
)

- **Swagger Documentation:** (https://linear-regression-model-lp6t.onrender.com/docs/)

---

### **Installation and Setup**

#### **Prerequisites:**

- **Flutter SDK 3.0+** (for the mobile application)
- **Android Studio** + emulator or physical Android device
- **Simulators:**
  - **Android Emulator** (via Android Studio) for testing Android applications.
  - **iOS Simulator** (via Xcode) for testing iOS applications.
  

#### **Setup Instructions:**

1. **Clone the Repository:**

   To get started, clone the repository to your local machine:

   ```bash
   git clone https://github.com/Deolinda1506/Linear_regression_model.git


## **Flutter App Setup:**

1. **Navigate to the Flutter project directory:**

   ```bash
   cd ./summative/Prediction_app
Get the Flutter dependencies:

```bash

flutter pub get
Run the app in development mode:

flutter run
If using an emulator: Ensure the Android/iOS simulator is running.


If using a physical device: Connect your device via USB and enable USB debugging.

To Build a Release Version:
For Android:


flutter build apk
For iOS:


flutter build ios
Running the API Locally:
Navigate to the API directory:

cd summative
Install the required Python packages:
python -m uvicorn --version or
pip install fastapi pydantic uvicorn



pip install -r requirements.txt
Start the server using Uvicorn:

python -m uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8000
uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8000
The API will be available at:


http://localhost:8000
Running the API Locally for Development:
If you need to run the API on your local machine for development purposes, follow these steps:

Activate your Python environment (optional, but recommended for managing dependencies):

For macOS/Linux:


python3 -m venv venv
source venv/bin/activate
For Windows:

python3 -m venv venv
venv\Scripts\activate
Install dependencies from requirements.txt:

pip install -r requirements.txt
Run the application using Uvicorn:
t
python -m uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8000

The API will be accessible at http://localhost:8000 and the Swagger documentation will be available at http://localhost:8000/docs.


