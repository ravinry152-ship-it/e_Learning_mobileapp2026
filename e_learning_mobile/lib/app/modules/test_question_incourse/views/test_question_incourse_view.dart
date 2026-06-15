import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/test_question_incourse_controller.dart';

class TestQuestionIncourseView extends GetView<TestQuestionIncourseController> {
  const TestQuestionIncourseView({super.key});

  @override
  Widget build(BuildContext context) {
    // កំណត់ទំហំអេក្រង់ទូរស័ព្ទ
    //final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 22), 
          onPressed: () => Get.back(),
        ),
        title: Text(
          'ធ្វេីតេស្តសម្ថភាព',
          style: GoogleFonts.kantumruyPro(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          // ប៊ូតុង Skip សំណួរ
          TextButton(
            onPressed: () {}, 
            child: Text(
              "រំលង",
              style: GoogleFonts.kantumruyPro(color: const Color(0xFF5C2D91), fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Column(
        
      ),
    );
  }
}