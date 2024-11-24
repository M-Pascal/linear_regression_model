import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers for user input
  final TextEditingController _commodityController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  String? _predictionResult; // To store the API response

  // Function to call the API
  Future<void> _fetchPrediction() async {
    const String apiUrl = "https://linear-regression-model-w35x.onrender.com/prediction";

    // Get input values
    final String commodity = _commodityController.text.trim();
    final String grade = _gradeController.text.trim();
    final String minPrice = _minPriceController.text.trim();
    final String maxPrice = _maxPriceController.text.trim();

    // Validate inputs
    if (commodity.isEmpty || grade.isEmpty || minPrice.isEmpty || maxPrice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required.")),
      );
      return;
    }

    double? minPriceValue = double.tryParse(minPrice);
    double? maxPriceValue = double.tryParse(maxPrice);

    if (minPriceValue == null || maxPriceValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid numbers for Min_Price and Max_Price.")),
      );
      return;
    }

    try {
      // Construct the request payload
      final Map<String, dynamic> payload = {
        "Min_Price": minPriceValue,
        "Max_Price": maxPriceValue,
        "Commodity": commodity,
        "Grade": grade,
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        // Parse the prediction result
        final data = jsonDecode(response.body);
        setState(() {
          _predictionResult = "Prediction: Price will be ${data['prediction'].toStringAsFixed(2)}₹ per quintal.";
        });
      } else if (response.statusCode == 422) {
        // Validation error handling
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Validation Error: ${errorData['detail'][0]['msg']}")),
        );
      } else {
        // Handle other API errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch prediction: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 56, 4, 1),
        toolbarHeight: 75,
        title: const Center(
          child: Text(
            'Crop Price Predictor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Section
            Stack(
              children: [
                // Background Image
                Image.network(
                  'https://www.greeningafrika.com/wp-content/uploads/2023/08/The-Important-role-of-Female-Farmers-in-Africa.jpeg',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                // Overlay Text
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sow the seeds of your dreams.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crop Information:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Commodity Input
                  TextField(
                    controller: _commodityController,
                    decoration: const InputDecoration(
                      labelText: 'Commodity',
                      hintText: 'Enter crop type (e.g., Corn, Wheat)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Grade Input
                  TextField(
                    controller: _gradeController,
                    decoration: const InputDecoration(
                      labelText: 'Grade',
                      hintText: 'Enter Small, Medium, or Large...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Min Price Input
                  TextField(
                    controller: _minPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Min_Price',
                      hintText: 'Enter Min_Price (e.g., 1200)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  // Max Price Input
                  TextField(
                    controller: _maxPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Max_Price',
                      hintText: 'Enter Max_Price (e.g., 2000)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  // Predict Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _fetchPrediction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 56, 4, 1),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text(
                        'PREDICT',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Prediction Output
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      _predictionResult ?? 'Enter details and press Predict to see results.',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
