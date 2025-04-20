import 'package:flutter_ui/headers.dart';

class ResultDiagnosisOfNormalFoot extends StatelessWidget {
  const ResultDiagnosisOfNormalFoot({
    super.key,
    required this.result,
  });
  final SimpleResult result;
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
                    Image.network(
                      genImgUrl(result.imgUrl),
                      height: 224,
                      width: 224,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox();
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     // First image
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/normal_foot1.jpg',
                    //         height: 100, // Fixed height for consistency
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     // Second image
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/normal_foot2.jpg',
                    //         height: 100,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     // Third image
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/normal_foot3.jpg',
                    //         height: 100,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //   ],
                    // ),

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

                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF33657D),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: Get.back,
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
