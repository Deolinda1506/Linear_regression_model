import asyncio
import uvicorn
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import pandas as pd

# Load trained model and preprocessor
model = joblib.load("summative/linear_regression/best_model.joblib")  # Adjust the path if necessary

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

# Define input schema with Pydantic and data constraints
class IncidentRequest(BaseModel):
    year: int = Field(..., ge=2000, le=2100, description="Year of incident (2000-2100)")
    financial_loss: float = Field(..., ge=0, description="Financial Loss in Million $ (≥0)")
    affected_users: int = Field(..., ge=0, description="Number of affected users (≥0)")
    target_industry: str = Field(..., description="Industry affected by the incident")
    attack_source: str = Field(..., description="Source of attack")
    vulnerability_type: str = Field(..., description="Type of security vulnerability exploited")
    defense_mechanism: str = Field(..., description="Defense mechanism used against the attack")

# Basic API test routes
@app.get("/class", status_code=status.HTTP_200_OK)
async def get_greet():
    return {"Message": "Hello API"}

@app.get("/", status_code=status.HTTP_200_OK)
async def get_hello():
    return {"hello": "Incident Resolution Time Prediction API"}

# Prediction route
@app.post('/predict', status_code=status.HTTP_200_OK)
async def make_prediction(incident_request: IncidentRequest):
    try:
        # Convert input to DataFrame
        input_data = pd.DataFrame([incident_request.dict()])

        # Apply preprocessing
        input_data_transformed = preprocessor.transform(input_data)

        # Make prediction using the model
        prediction = model.predict(input_data_transformed)

        return {"Predicted Resolution Time (in Hours)": round(prediction[0], 2)}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Run server
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
