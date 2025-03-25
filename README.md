Predicting Incident Resolution Time App
Mission:
Predict the time it takes to resolve cybersecurity incidents based on historical threat data, helping organizations:

Assess incident resolution efficiency

Optimize resource allocation for incident handling

Anticipate future cybersecurity challenges

Enhance response strategies through data-driven insights

Demo Video:
Watch the demo

Dataset Description:
Source: Global Cybersecurity Threats (2015-2024) Dataset on Kaggle

This dataset contains cybersecurity incident data with several features, which can be used to predict incident resolution times.

Key Features:

Threat Type: Type of cybersecurity threat

Incident Category: Category of the incident (e.g., Phishing, Ransomware, etc.)

Year: Year of the incident (2015-2024)

Incident Duration: Time taken to resolve the incident (target variable)

Incident Severity: Severity level of the incident (scale)

Response Time: Initial response time to the incident

Resources Allocated: Resources used to resolve the incident

Analysis Objectives:
Analyze factors affecting cybersecurity incident resolution time

Build predictive models to estimate incident resolution time

Assist organizations in improving incident response efficiency

API:
Prediction Endpoint (POST): https://linear-regression-model-lp6t.onrender.com/predict_yield/

Swagger Endpoint: https://linear-regression-model-lp6t.onrender.com/docs/

Installation and Setup
Prerequisites:
Flutter SDK 3.0+ for the mobile application

Android Studio + emulator or physical Android device

Setup:
Clone the repository:

bash
Copy
Edit
git clone https://github.com/Deolinda1506/Linear_regression_model.git
Flutter App Setup: Navigate to the Flutter project directory:

bash
Copy
Edit
cd ./linear_regression_model/summative/FluttterApp
Get Flutter dependencies:

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

To build a release version:

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
Install required Python packages:

bash
Copy
Edit
pip install -r requirements.txt
Start the server with uvicorn:

bash
Copy
Edit
uvicorn summative.API.prediction:app --host 0.0.0.0 --port 8000
The API will be available at:
http://localhost:8000
