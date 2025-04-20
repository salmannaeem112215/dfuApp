import 'package:flutter/material.dart';
import 'result_diagnosis_of_abnormal_foot.dart'; // تأكد من استيراد الصفحة الجديدة هنا

class ResultDiagnosisOfNormalFoot extends StatelessWidget {
  final String diabetesDuration;
  final String footCare;
  final String hadUlcerBefore;
  final String imagePath;

  const ResultDiagnosisOfNormalFoot({
    Key? key,
    required this.diabetesDuration,
    required this.footCare,
    required this.hadUlcerBefore,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Diagnosis Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF33657D),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultDiagnosisOfAbnormalFoot(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "You have normal skin" text inside its slightly transparent box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(
                      0x8033657D), // Slight transparency (80% opacity)
                  borderRadius:
                      BorderRadius.circular(8), // Soft rounded corners
                ),
                child: const Center(
                  child: Text(
                    'You have normal skin.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // The rest of the content in another white rectangle
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Row for the foot images with a small gap between them
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First image
                        Expanded(
                          child: Image.asset(
                            'assets/images/normal_foot1.jpg',
                            height: 100, // Fixed height for consistency
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Second image
                        Expanded(
                          child: Image.asset(
                            'assets/images/normal_foot2.jpg',
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Third image
                        Expanded(
                          child: Image.asset(
                            'assets/images/normal_foot3.jpg',
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Final descriptive text in bold
                    const Text(
                      'Your skin is normal and you do not suffer from diabetic foot ulcers.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
