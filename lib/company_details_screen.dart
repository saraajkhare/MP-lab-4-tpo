import 'package:flutter/material.dart';

class CompanyDetailsPage extends StatelessWidget {
  const CompanyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> companies = [
      {
        "name": "Company A",
        "location": "City A",
        "salary": "₹50k - ₹70k",
      },
      {
        "name": "Company B",
        "location": "City B",
        "salary": "₹60k - ₹80k",
      },
      {
        "name": "Company C",
        "location": "City C",
        "salary": "₹55k - ₹75k",
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            return Card(
              elevation: 4, // Shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company["name"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 180, 143, 204),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "📍 Location: ${company["location"]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "💰 Salary Range: ${company["salary"]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
