import joblib
import pandas as pd
import uvicorn
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware

# Load trained model
model = joblib.load("summative/linear_regression/best_model.joblib")

# Create FastAPI instance
app = FastAPI(title="Incident Resolution Time Prediction API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)

# Define input schema
class IncidentRequest(BaseModel):
    Year: int = Field(..., ge=2000, le=2100, description="Year of incident (2000-2100)")
    Financial_Loss_in_Million: float = Field(..., ge=0, description="Financial Loss in Million $ (≥0)")
    Number_of_Affected_Users: int = Field(..., ge=0, description="Number of affected users (≥0)")
    Target_Industry: str = Field(..., description="Industry affected by the incident")
    Attack_Source: str = Field(..., description="Source of attack")
    Security_Vulnerability_Type: str = Field(..., description="Type of security vulnerability exploited")
    Defense_Mechanism_Used: str = Field(..., description="Defense mechanism used against the attack")
    Country: str = Field(..., description="Country of the incident")  # Add Country field
    Attack_Type: str = Field(..., description="Type of attack")  # Add Attack_Type field


# Prediction function
def predict_resolution_time(input_data):
    prediction = model.predict(input_data)
    return prediction[0]


# API Test Route
@app.get("/", status_code=status.HTTP_200_OK)
async def root():
    return {"message": "Incident Resolution Time Prediction API is running"}


# Prediction Route
@app.post("/predict", status_code=status.HTTP_200_OK)
async def make_prediction(incident_request: IncidentRequest):
    try:
        # Create input DataFrame with correct column names
        input_data = pd.DataFrame([{
            "Year": incident_request.Year,
            "Financial Loss (in Million $)": incident_request.Financial_Loss_in_Million,  # Correct column name
            "Number of Affected Users": incident_request.Number_of_Affected_Users,
            "Target Industry": incident_request.Target_Industry,
            "Attack Source": incident_request.Attack_Source,
            "Security Vulnerability Type": incident_request.Security_Vulnerability_Type,
            "Defense Mechanism Used": incident_request.Defense_Mechanism_Used,
            "Country": incident_request.Country,  # Include Country
            "Attack Type": incident_request.Attack_Type  # Include Attack_Type
        }])

        # Make prediction
        predicted_resolution_time = predict_resolution_time(input_data)

        return {"predicted_resolution_time": predicted_resolution_time}

    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))