import 'package:flutter_ui/headers.dart';

class ResultDiagnosisOfAbnormalFoot extends StatelessWidget {
  const ResultDiagnosisOfAbnormalFoot({
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0x8033657D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'You have diabetic foot ulcers.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/abnormal_foot1.jpg',
                    //         height: 100,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/abnormal_foot2.jpg',
                    //         height: 100,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Expanded(
                    //       child: Image.asset(
                    //         'assets/images/abnormal_foot3.jpg',
                    //         height: 100,
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 16),
                    const Text(
                      'It is a skin ulcer that appears in the foot area, as a result of the effect of diabetes on the nerves and blood vessels, especially in the lower extremities.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MedicalAdvice(), // الانتقال إلى صفحة MedicalAdvice
                      ),
                    );
                  },
                  child: const Text(
                    'Get medical advice',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
      ),
    );
  }
}
