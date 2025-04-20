import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/questionnaire_page.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF33657D),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Getting Started',
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF182F3A),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'By using DiaFootCare, you agree to provide accurate personal and medical information, including images, for the purpose of diagnosis and health monitoring. Your data will be securely stored and used in compliance with relevant privacy regulations, and will not be shared with third parties without your explicit consent, except as required by law. We implement robust measures to protect your data and ensure its confidentiality. You retain the right to access, correct, or request the deletion of your data by contacting us at +966555555. Continued use of the application signifies your acceptance of these Terms and Conditions.',
                style: TextStyle(fontSize: screenWidth * 0.035),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Agree on terms and conditions',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF33657D),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isChecked
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionnairePage(),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    'Agree',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
