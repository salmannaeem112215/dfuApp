import 'package:flutter/material.dart';
import 'contact_doctors.dart';


class MedicalAdvice extends StatefulWidget {
  const MedicalAdvice({super.key});

  @override
  State<MedicalAdvice> createState() => _MedicalAdviceState();
}

class _MedicalAdviceState extends State<MedicalAdvice> {
  int _currentAdviceIndex = 0;
  bool _showDoctorAdvice = false;

  final List<List<String>> adviceList = [
    [
      "Clean the ulcer and remove dead skin and tissue.",
      "Apply antibiotic ointment to the ulcer.",
      "The area is covered with a bandage to keep it clean and moist."
    ],
    [
      "The ulcer should be cleaned and a clean bandage applied twice daily.",
      "Raise the foot with the ulcer off the ground as much as possible."
    ],
  ];

  final List<String> doctorAdvice = [
    "When dry black tissue appears.",
    "If part of the toes or foot is severely damaged.",
    "If the wound does not improve within 3 weeks"
  ];

  void _nextAdvice() {
    if (_currentAdviceIndex < adviceList.length - 1) {
      setState(() {
        _currentAdviceIndex++;
      });
    }
  }

  void _previousAdvice() {
    if (_currentAdviceIndex > 0) {
      setState(() {
        _currentAdviceIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Medical Advice', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF33657D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...adviceList[_currentAdviceIndex].map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            const Icon(Icons.brightness_1,
                                size: 6, color: Colors.black),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              size: 18, color: Color(0xFF33657D)),
                          onPressed: _previousAdvice,
                        ),
                        Row(
                          children: List.generate(adviceList.length, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                                color: _currentAdviceIndex == index
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Color(0xFF33657D)),
                          onPressed: _nextAdvice,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity, // استخدام العرض الكامل هنا
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0), // تم تعديل العرض والسمك هنا
                decoration: BoxDecoration(
                  color: const Color(0x8033657D),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showDoctorAdvice = !_showDoctorAdvice;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'When should you see a doctor?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        _showDoctorAdvice
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_showDoctorAdvice)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: doctorAdvice.map((tip) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.brightness_1,
                                size: 6, color: Colors.black),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tip,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF33657D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  ContactDoctorsPage()),
  );
},

                
                child: const Text(
                  "Get a doctor's number",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
