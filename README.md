# **Crop Price prediction Project**

This repository contains a comprehensive solution for predicting Crop price using a Flutter mobile application integrated with a FastAPI-based backend. It allows users to input relevant parameters and receive real-time predictions via a publicly accessible API.

## **Project Overview**

This project is divided into three main components:  

1. **Machine Learning Model**  
   - A regression model predicts commodity price (crop price per quintal) based on parameters such as commodity name, grade, maximum price occurred, and minimum price occurred on the market recently.  
   - The model was trained using a hypothetical dataset and deployed through a RESTful API.  

2. **FastAPI Backend**  
   - A FastAPI-based RESTful API serves the trained machine learning model.  
   - The API accepts structured input, validates it, and returns predictions.  
   - Hosted with a publicly accessible Swagger UI for testing.  

3. **Flutter Frontend**  
   - A mobile app built with Flutter provides an interface for users to enter input data and view predictions.  
   - Features include text fields for input, a "Predict" button to call the API, and a display area for results.  

---

## **Features**

### **API**
- **Endpoint**: `/prediction` (POST request)  
- **Input**: JSON payload containing required parameters:  
    - Commodity
    - Grade (e.g. Small, Medium, Large, FAQ)
    - Min_price
    - Max_price   
- **Output**: JSON response with Model price of commodity.  

### **Flutter App**
- **Input Fields**: Dynamic text fields for all required input parameters.  
- **Predict Button**: Triggers the API call to fetch predictions.  
- **Results Display**: Shows the predicted modal price of commodity or appropriate error messages.  
- **Responsive Design**: Clean UI ensuring usability across devices.  

---

### **Dataset Source:**  
I got the dataset from Kaggle website::  
click here to **[Download](https://www.kaggle.com/code/rishabhkothari103/linear-regression-to-predict-agricultural-prices/notebook)** the same dataset.

## **Demo**

### **API Testing**  
Test the API directly via its Swagger UI interface:  
**[Swagger UI Endpoint](https://linear-regression-model-w35x.onrender.com)**  

1. Open the link above.  
2. Click on the `/prediction` POST endpoint.  
3. Click "Try it out" to enter input parameters.  
4. Submit the request and view the prediction.  

### **YouTube Demo**  
Watch the video demo of the app in action:  
**[YouTube Link](https://youtu.be/ISFDVA9unAE)**

---

## **How to Run the Project**

### **API**  
1. Clone the repository:  
   ```bash
   git clone https://github.com/M-Pascal/linear_regression_model.git
   cd linear_regression_model/API
   ```
2. Install dependencies:  
   ```bash
   pip install -r requirements.txt
   ```
3. Run the FastAPI server:  
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000
   ```
4. Ensure the API is accessible at a publicly routable URL (e.g., deployed via Render or others). Update the Flutter app with this URL.

### **Flutter App**  
1. Navigate to the `crop_price` directory:  
   ```bash
   cd linear_regression_model/summative/flutter_app/crop_price
   ```
2. Install Flutter dependencies:  
   ```bash
   flutter pub get
   ```
3. Update the `apiUrl` in `main.dart` to match your deployed API endpoint:  
   ```dart
   final String apiUrl = 'https://linear-regression-model-w35x.onrender.com';
   ```
4. Run the Flutter app:  
   ```bash
   flutter run
   ```

---

## **Deployment**

### **API Hosting**  
The FastAPI backend is deployed at:  
**[Swagger UI URL Link](https://linear-regression-model-w35x.onrender.com)**

### **Flutter App Deployment**  
- Test and smoothly running the Flutter app to physical or virtual mobile devices.  

---

## **Technical Details**

### **Dataset**  
The project uses a simulated dataset capturing features such as:  
- Commodity
- Grade (e.g. Small, Medium, Large, FAQ)
- Min_price
- Max_price
**N.B:** Maximum price has to be greater than minimum price.


### **Model Training**  
The machine learning model was built using linear regression. It was evaluated on metrics like (RMSE) and deployed as the API backend.  

---

## **Results**  
- The app predicts ```Crop price``` accurately based on input data.  
- The API performs validations to ensure input quality.  
- The user-friendly Flutter app simplifies the prediction process.  

---

## **Contact**  
For questions or support you can reach-out to contact me: 
- **Full-Name**: Pascal Mugisha 
- **Email**: <p.mugisha@alustudent.com> 
