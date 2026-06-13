import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; 
import '../controllers/view_book_controller.dart';

class ViewBookView extends StatelessWidget {
  const ViewBookView({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(ViewBookController());

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E2CB1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          con.selectedBook.value?.title ?? "កំពុងបើកសៀវភៅ...",
          style: GoogleFonts.kantumruyPro(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (con.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0E2CB1)),
          );
        }

        if (con.pdfPath.isEmpty) {
          return Center(
            child: Text(
              "មិនអាចទាញយកឯកសារ PDF បានទេ!",
              style: GoogleFonts.kantumruyPro(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          );
        }

        // ៣. បើទាញយករួចរាល់ ហៅ Widget មកបើកបង្ហាញហ្វាយ PDF ពីក្នុងម៉ាស៊ីន (Local File)
        return PDFView(
          filePath: con.pdfPath.value,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
          onError: (error) {
            debugPrint("បង្ហាញ PDF មានបញ្ហា: $error");
          },
        );
      }),
    );
  }
}