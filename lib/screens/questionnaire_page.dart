import 'package:flutter_ui/headers.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  String diabetesDuration = '';
  String footCare = '';
  String hadUlcerBefore = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width.clamp(300.0, 1000.0);
    final screenHeight =
        MediaQuery.of(context).size.height.clamp(300.0, 1000.0);
    final fontSize = screenWidth * 0.045;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () {
            if (Get.previousRoute == AppRoutes.rProfile) {
              Get.back();
            } else {
              Get.offAndToNamed(AppRoutes.rHome);
            }
          },
        ),
        title:
            const Text('Questionnaire', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF33657D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestionText(
                  'For how long have you had diabetes?', fontSize),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildOptionButton('Less than 10 years', diabetesDuration,
                      (val) {
                    diabetesDuration = val;
                  }, screenWidth),
                  _buildOptionButton('More than 10 years', diabetesDuration,
                      (val) {
                    diabetesDuration = val;
                  }, screenWidth),
                ],
              ),
              const SizedBox(height: 16),
              _buildQuestionText('Do you take care of your foot?', fontSize),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildOptionButton('No', footCare, (val) {
                    footCare = val;
                  }, screenWidth),
                  _buildOptionButton('Yes', footCare, (val) {
                    footCare = val;
                  }, screenWidth),
                  _buildOptionButton('Often', footCare, (val) {
                    footCare = val;
                  }, screenWidth),
                ],
              ),
              const SizedBox(height: 16),
              _buildQuestionText(
                  'Did you have a diabetic foot ulcer before?', fontSize),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildOptionButton('No', hadUlcerBefore, (val) {
                    hadUlcerBefore = val;
                  }, screenWidth),
                  _buildOptionButton('Yes', hadUlcerBefore, (val) {
                    hadUlcerBefore = val;
                  }, screenWidth),
                ],
              ),
              SizedBox(height: screenHeight * 0.08),
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
                  onPressed: () {
                    _submitQuestionnaire();
                  },
                  child: Text('Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 81, 79, 79),
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOptionButton(String text, String selectedValue,
      Function(String) onSelect, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.42,
      child: GestureDetector(
        onTap: () {
          setState(() {
            onSelect(text);
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color:
                selectedValue == text ? const Color(0xFF33657D) : Colors.white,
            border: Border.all(color: const Color(0xFF33657D)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selectedValue == text
                    ? Colors.white
                    : const Color(0xFF33657D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitQuestionnaire() async {
    bool isValid = diabetesDuration.isNotEmpty &&
        footCare.isNotEmpty &&
        hadUlcerBefore.isNotEmpty;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    _onUpdateData();
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => ImageSelectionScreen(
    //     diabetesDuration: diabetesDuration,
    //     footCare: footCare,
    //     hadUlcerBefore: hadUlcerBefore,
    //   ),
    // ));
  }

  void _onUpdateData() async {
    try {
      await Get.find<AppController>().updateQuestionaries(
        MyQuestionaries(
          diabetesDuration: diabetesDuration,
          footCare: footCare,
          hadUlcerBefore: hadUlcerBefore,
        ),
      );
      if (Get.previousRoute == AppRoutes.rProfile) {
        Get.back(result: true);
      } else {
        Get.offAndToNamed(AppRoutes.rHome);
      }
    } catch (e) {
      MySnackbar.error('Unable To Update');
    }
  }
}
