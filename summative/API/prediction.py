import asyncio
import uvicorn
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import pandas as pd

# Load trained model
model = joblib.load("summative/linear_regression/best_model.joblib")  # Adjust the path if necessary

# Create FastAPI instance
app = FastAPI(title="Wine Quality Prediction API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["GET", "POST"],  
    allow_headers=["*"],  
)

# Define input schema with Pydantic and data constraints
class WineQualityRequest(BaseModel):
    type: str = Field(..., description="Type of wine (red or white)", regex="^(red|white)$")
    fixed_acidity: float = Field(..., gt=0, description="Fixed acidity level (>0)")
    volatile_acidity: float = Field(..., ge=0, le=2, description="Volatile acidity (0 to 2)")
    citric_acid: float = Field(..., ge=0, le=1, description="Citric acid (0 to 1)")
    residual_sugar: float = Field(..., ge=0, description="Residual sugar level (>0)")
    chlorides: float = Field(..., ge=0, le=1, description="Chloride content (0 to 1)")
    free_sulfur_dioxide: float = Field(..., ge=0, le=100, description="Free sulfur dioxide (0 to 100)")
    total_sulfur_dioxide: float = Field(..., ge=0, le=400, description="Total sulfur dioxide (0 to 400)")
    density: float = Field(..., ge=0.98, le=1.05, description="Density (0.98 to 1.05)")
    pH: float = Field(..., ge=2.5, le=4.5, description="pH level (2.5 to 4.5)")
    sulphates: float = Field(..., ge=0, le=2, description="Sulphates (0 to 2)")
    alcohol: float = Field(..., ge=0, le=20, description="Alcohol content (0 to 20%)")

# Basic testing routes
@app.get("/class", status_code=status.HTTP_200_OK)
async def get_greet():
    return {"Message": "Hello API"}

@app.get("/", status_code=status.HTTP_200_OK)
async def get_hello():
    return {"hello": "Wine Quality Prediction API"}

# Prediction route with input constraints
@app.post('/predict', status_code=status.HTTP_200_OK)
async def make_prediction(wine_request: WineQualityRequest):
    try:
        # Convert input to DataFrame
        input_data = pd.DataFrame([wine_request.dict()])

        # Make prediction using the model
        prediction = model.predict(input_data)

        return {"Predicted Quality": int(prediction[0])}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Run server
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
