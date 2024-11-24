import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  height: 250,
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
            const SizedBox(height: 20),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crop Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Commodity Input (e.g., Maize, Wheat, etc.)
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Commodity',
                      hintText: 'Enter crop type (e.g., Corn, Wheat)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // type of crops (e.g., small grain)
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Grade',
                      hintText: 'Enter Small,Medium,or Large...',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  // The minimum price once happened on the market
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Min_Price',
                      hintText: 'Enter Min_Price (e.g., 1200)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // The maximum price once happened on the market
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Max_Price',
                      hintText: 'Enter Min_Price(e.g., 2000)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Predict Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle predict action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 56, 4, 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                      ),
                      child: const Text(
                        'PREDICT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Prediction Output
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Text(
                      'Prediction: Example; Price of corn flour will be 750rwf/kg in June-Aug 2024, and will increase by 7.6% in Kigali compared to other locations.',
                      style: TextStyle(fontSize: 16),
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
