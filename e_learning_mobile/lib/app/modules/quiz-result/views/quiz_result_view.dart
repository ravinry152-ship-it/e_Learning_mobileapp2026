import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/quiz_result_controller.dart';

class QuizResultView extends GetView<QuizResultController> {
  const QuizResultView({super.key});

  @override
  Widget build(BuildContext context) {
    //  ចាប់យកទិន្នន័យដែលបោះមកពី Page មុន (response.data របស់ Django)
    final Map<String, dynamic> resultData = Get.arguments ?? {
      "score": 0,
      "total_questions": 0,
      "correct_answers": 0,
      "message": "មិនមានទិន្នន័យ"
    };

    final int score = resultData['score'] ?? 0;
    final int totalQuestions = resultData['total_questions'] ?? 0;
    final int correctAnswers = resultData['correct_answers'] ?? 0;
    
    //  កំណត់ស្ទីលពណ៌ និងសារទៅតាមកម្រិតពិន្ទុ (ជាប់ ឬធ្លាក់)
    final bool isPassed = score >= 50; 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, //  បិទប៊ូតុង Back កុំឱ្យសិស្សចុចថយក្រោយទៅផ្ទាំងប្រឡងវិញ
        title: Text(
          'លទ្ធផលប្រឡង',
          style: GoogleFonts.kantumruyPro(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // រូបតំណាង Badge / Icon ជោគជ័យ ឬធ្លាក់
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isPassed ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPassed ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                  color: isPassed ? Colors.green : Colors.red,
                  size: 90,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                isPassed ? "អបអរសាទរ! អ្នកបានប្រឡងជាប់" : "ព្យាយាមម្តងទៀត! កុំអាលបាក់ទឹកចិត្ត",
                textAlign: TextAlign.center,
                style: GoogleFonts.kantumruyPro(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
              const SizedBox(height: 8),
              
              Text(
                "អ្នកបានបញ្ចប់ការធ្វើតេស្តវាយតម្លៃសមត្ថភាពហើយ",
                style: GoogleFonts.kantumruyPro(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 35),

              // រង្វង់បង្ហាញពិន្ទុធំចំកណ្តាល (Score Ring)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey.shade100,
                      color: isPassed ? const Color(0xFF5C2D91) : Colors.redAccent,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "$score",
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 48,
                          //fontWeight: FontWeight.b,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "ពិន្ទុសរុប",
                        style: GoogleFonts.kantumruyPro(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 📋 កាតបង្ហាញព័ត៌មានលម្អិត (Stats Card)
              Card(
                elevation: 0,
                color: Colors.grey.shade50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        icon: Icons.check_circle,
                        iconColor: Colors.green,
                        label: "ឆ្លើយត្រូវ",
                        value: "$correctAnswers ឆ្លើយតប",
                      ),
                      Container(width: 1, height: 40, color: Colors.grey.shade300),
                      _buildStatItem(
                        icon: Icons.assignment,
                        iconColor: const Color(0xFF5C2D91),
                        label: "សំណួរសរុប",
                        value: "$totalQuestions សំណួរ",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // ប៊ូតុងរុករក (Navigation Action Buttons)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C2D91), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'ត្រឡប់ទៅកាន់ទំព័រដើម',
                    style: GoogleFonts.kantumruyPro(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ជំនួយសម្រាប់បង្ហាញធាតុព័ត៌មានលម្អិតតូចៗ
  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.kantumruyPro(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.kantumruyPro(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}