from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import Literal
import pickle
import logging
import pandas as pd
from starlette.middleware.base import BaseHTTPMiddleware
from fastapi.responses import RedirectResponse


# Initialize FastAPI app
app = FastAPI()


# Load encoders and the trained model
with open('encoding.pkl', 'rb') as f:
    encoding = pickle.load(f)

energy_model = pickle.load(open('linear_model.sav', 'rb'))

# Define the input model
class model_input(BaseModel):
    Min_Price: float = Field(..., ge=-50)
    Max_Price: float = Field(..., ge=-50)
    Commodity: str
    Grade: str


@app.get("/")
def redirect_to_docs():
    return RedirectResponse(url="/docs")

# Define the POST endpoint
@app.post('/prediction')
def commodity_pred(input_parameters: model_input):
    try:
        # Transform categorical
        input_data = {
            'Min_Price': input_parameters.Min_Price,
            'Max_Price': input_parameters.Max_Price,
            'Commodity_encoded': encoding['Commodity'].transform([input_parameters.Commodity])[0]
                               if input_parameters.Commodity in encoding['Commodity'].classes_
                               else -1,
            'Grade_encoded': encoding['Grade'].transform([input_parameters.Grade])[0]
                             if input_parameters.Grade in encoding['Grade'].classes_
                             else -1
        }

        input_data_df = pd.DataFrame([input_data])

        logging.info(f"Encoded input data: {input_data_df}")

        prediction = energy_model.predict(input_data_df)

        return {"prediction": prediction[0]}

    except Exception as e:
        logging.error(f"Error during prediction: {e}")
        return {"error": "Prediction failed.", "details": str(e)}
