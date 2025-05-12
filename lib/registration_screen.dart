import 'dart:io';
// Required for web file handling
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for marks & calculations
  final TextEditingController _hscTotalController = TextEditingController();
  final TextEditingController _hscOutOfController = TextEditingController();
  final TextEditingController _sscTotalController = TextEditingController();
  final TextEditingController _sscOutOfController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();

  double? hscPercentage;
  double? sscPercentage;
  double? cgpaPercentage;

  // Resume handling
  File? resumeFile;
  Uint8List? resumeBytes;
  String? resumeName;

  // Form field validation
  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // HSC Percentage Calculation
  void calculateHSCPercentage() {
    if (_hscTotalController.text.isNotEmpty &&
        _hscOutOfController.text.isNotEmpty) {
      double total = double.tryParse(_hscTotalController.text) ?? 0;
      double outOf = double.tryParse(_hscOutOfController.text) ?? 1;
      setState(() {
        hscPercentage = (total / outOf) * 100;
      });
    }
  }

  // SSC Percentage Calculation
  void calculateSSCPercentage() {
    if (_sscTotalController.text.isNotEmpty &&
        _sscOutOfController.text.isNotEmpty) {
      double total = double.tryParse(_sscTotalController.text) ?? 0;
      double outOf = double.tryParse(_sscOutOfController.text) ?? 1;
      setState(() {
        sscPercentage = (total / outOf) * 100;
      });
    }
  }

  // CGPA to Percentage Conversion
  void calculateCGPAPercentage() {
    if (_cgpaController.text.isNotEmpty) {
      double cgpa = double.tryParse(_cgpaController.text) ?? 0;
      setState(() {
        cgpaPercentage = cgpa * 9.5; // Standard conversion
      });
    }
  }

  // File Picker (Web & Mobile)
  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          resumeBytes = result.files.single.bytes;
          resumeName = result.files.single.name;
        } else {
          resumeFile = File(result.files.single.path!);
          resumeName = resumeFile!.path.split('/').last;
        }
      });
    }
  }

  // Open Resume (Only for mobile)
  void viewResume() {
    if (!kIsWeb && resumeFile != null) {
      OpenFile.open(resumeFile!.path);
    }
  }

  // Submit Form
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (resumeBytes == null && resumeFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload your resume!')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Submitted Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: validateField,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]')
                      .hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Roll No'),
                validator: validateField,
              ),

              // HSC Details
              SizedBox(height: 20),
              Text("HSC Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                  decoration: InputDecoration(labelText: 'HSC College'),
                  validator: validateField),
              TextFormField(
                  decoration: InputDecoration(labelText: 'HSC Year of Passing'),
                  keyboardType: TextInputType.number,
                  validator: validateField),
              TextFormField(
                controller: _hscTotalController,
                decoration: InputDecoration(labelText: 'HSC Total Marks'),
                keyboardType: TextInputType.number,
                onChanged: (_) => calculateHSCPercentage(),
              ),
              TextFormField(
                controller: _hscOutOfController,
                decoration: InputDecoration(labelText: 'HSC Out Of'),
                keyboardType: TextInputType.number,
                onChanged: (_) => calculateHSCPercentage(),
              ),
              if (hscPercentage != null)
                Text("HSC Percentage: ${hscPercentage!.toStringAsFixed(2)}%"),

              // SSC Details
              SizedBox(height: 20),
              Text("SSC Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                  decoration: InputDecoration(labelText: 'SSC College'),
                  validator: validateField),
              TextFormField(
                  decoration: InputDecoration(labelText: 'SSC Year of Passing'),
                  keyboardType: TextInputType.number,
                  validator: validateField),
              TextFormField(
                controller: _sscTotalController,
                decoration: InputDecoration(labelText: 'SSC Total Marks'),
                keyboardType: TextInputType.number,
                onChanged: (_) => calculateSSCPercentage(),
              ),
              TextFormField(
                controller: _sscOutOfController,
                decoration: InputDecoration(labelText: 'SSC Out Of'),
                keyboardType: TextInputType.number,
                onChanged: (_) => calculateSSCPercentage(),
              ),
              if (sscPercentage != null)
                Text("SSC Percentage: ${sscPercentage!.toStringAsFixed(2)}%"),

              // CGPA
              SizedBox(height: 20),
              Text("Sem 1-5 CGPA",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _cgpaController,
                decoration: InputDecoration(labelText: 'CGPA'),
                keyboardType: TextInputType.number,
                onChanged: (_) => calculateCGPAPercentage(),
              ),
              if (cgpaPercentage != null)
                Text(
                    "Equivalent Percentage: ${cgpaPercentage!.toStringAsFixed(2)}%"),

              // Resume Upload
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: pickResume,
                icon: Icon(Icons.upload_file),
                label: Text('Choose File'),
              ),
              if (resumeName != null) Text("Uploaded: $resumeName"),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
