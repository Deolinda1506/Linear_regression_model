import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(IncidentPredictionApp());
}

class IncidentPredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Incident Prediction',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController yearController = TextEditingController();
  final TextEditingController lossController = TextEditingController();
  final TextEditingController usersController = TextEditingController();
  final TextEditingController industryController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController vulnerabilityController = TextEditingController();
  final TextEditingController defenseController = TextEditingController();

  String predictionResult = "";
  bool isLoading = false;

  Future<void> predict() async {
    setState(() => isLoading = true);

    final url = Uri.parse("https://linear-regression-model-lp6t.onrender.com/predict");

    final Map<String, dynamic> requestBody = {
      "Year": int.tryParse(yearController.text) ?? 0,
      "Financial_Loss_in_Million": double.tryParse(lossController.text) ?? 0.0,
      "Number_of_Affected_Users": int.tryParse(usersController.text) ?? 0,
      "Target_Industry": industryController.text,
      "Attack_Source": sourceController.text,
      "Security_Vulnerability_Type": vulnerabilityController.text,
      "Defense_Mechanism_Used": defenseController.text,
    };

    try {
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictionResult = "Predicted Resolution Time: ${data['Predicted Incident Resolution Time (in Hours)']} hours";
        });
      } else {
        setState(() => predictionResult = "Error: ${response.body}");
      }
    } catch (e) {
      setState(() => predictionResult = "Failed to connect to API");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildTextField(TextEditingController controller, String label, TextInputType type) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incident Resolution Prediction")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField(yearController, 'Year', TextInputType.number),
              SizedBox(height: 12),
              buildTextField(lossController, 'Financial Loss (in Million \$)', TextInputType.number),
              SizedBox(height: 12),
              buildTextField(usersController, 'Number of Affected Users', TextInputType.number),
              SizedBox(height: 12),
              buildTextField(industryController, 'Target Industry', TextInputType.text),
              SizedBox(height: 12),
              buildTextField(sourceController, 'Attack Source', TextInputType.text),
              SizedBox(height: 12),
              buildTextField(vulnerabilityController, 'Security Vulnerability Type', TextInputType.text),
              SizedBox(height: 12),
              buildTextField(defenseController, 'Defense Mechanism Used', TextInputType.text),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : predict,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Predict", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              Text(
                predictionResult,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

