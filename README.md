Predicting Incident Resolution Time App
Mission:
The goal of this application is to predict the time it takes to resolve cybersecurity incidents based on historical threat data. By doing so, organizations can:

Assess incident resolution efficiency

Optimize resource allocation for incident handling

Anticipate future cybersecurity challenges

Enhance response strategies through data-driven insights

Demo Video:
Watch the demo video

Dataset Description:
Source: Global Cybersecurity Threats (2015-2024) Dataset on Kaggle

This dataset contains information about cybersecurity incidents with several key features that can be used to predict incident resolution times.

Key Features:
Threat Type: Type of cybersecurity threat

Incident Category: Category of the incident (e.g., Phishing, Ransomware, etc.)

Year: Year of the incident (2015-2024)

Incident Duration: Time taken to resolve the incident (target variable)

Incident Severity: Severity level of the incident (scale)

Response Time: Initial response time to the incident

Resources Allocated: Resources used to resolve the incident

Analysis Objectives:
Analyze the factors that affect cybersecurity incident resolution times.

Build predictive models to estimate the resolution time for future incidents.

Assist organizations in improving their incident response strategies and efficiency.

API Endpoints:
Prediction Endpoint (POST): https://linear-regression-model-lp6t.onrender.com/predict_yield/

Swagger Documentation: https://linear-regression-model-lp6t.onrender.com/docs/

Installation and Setup
Prerequisites:
Flutter SDK 3.0+ (for the mobile application)

Android Studio + emulator or physical Android device

Setup Instructions:
Clone the Repository:

To get started, clone the repository to your local machine:

bash
Copy
Edit
git clone https://github.com/Deolinda1506/Linear_regression_model.git
Flutter App Setup:

Navigate to the Flutter project directory:

bash
Copy
Edit
cd ./linear_regression_model/summative/FluttterApp
Get the Flutter dependencies:

bash
Copy
Edit
flutter pub get
Run the app in development mode:

bash
Copy
Edit
flutter run
If using an emulator: Ensure the Android/iOS emulator is running.

If using a physical device: Connect your device via USB and enable USB debugging.

To Build a Release Version:

For Android:

bash
Copy
Edit
flutter build apk
For iOS:

bash
Copy
Edit
flutter build ios
Running the API Locally
Navigate to the API directory:

bash
Copy
Edit
cd ./linear_regression_model/summative/API
Install the required Python packages:

bash
Copy
Edit
pip install -r requirements.txt
Start the server using Uvicorn:

bash
Copy
Edit
uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8000
The API will be available at:

arduino
Copy
Edit
http://localhost:8000
