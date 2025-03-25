import asyncio
import uvicorn
from typing import Annotated
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import joblib
import pandas as pd

# Load trained model
model = joblib.load("summative/linear_regression/best_model.joblib")  # Update the path if necessary

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

# Define input schema with Pydantic
class WineQualityRequest(BaseModel):
    type: str
    fixed_acidity: float
    volatile_acidity: float
    citric_acid: float
    residual_sugar: float
    chlorides: float
    free_sulfur_dioxide: float
    total_sulfur_dioxide: float
    density: float
    pH: float
    sulphates: float
    alcohol: float

# Basic testing routes
@app.get("/class", status_code=status.HTTP_200_OK)
async def get_greet():
    return {"Message": "Hello API"}

@app.get("/", status_code=status.HTTP_200_OK)
async def get_hello():
    return {"hello": "Wine Quality Prediction API"}

# Prediction route
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

