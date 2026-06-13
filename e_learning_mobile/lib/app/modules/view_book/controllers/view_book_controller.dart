import 'dart:io';
import 'package:e_learning_mobile/app/modules/model/book_model.dart'; 
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class ViewBookController extends GetxController {
  final api = Get.find<ApiProvider>();
   var isLoading = true.obs;
  var pdfPath = "".obs;
  
  // បង្កើត variable មួយសម្រាប់រក្សាទុកព័ត៌មានសៀវភៅដែលចុចមើល
  Rxn<Books> selectedBook = Rxn<Books>();

  @override
  void onInit() {
    super.onInit();
    
    // ចាប់យកទិន្នន័យសៀវភៅដែលបោះមកពីទំព័រមុន
    if (Get.arguments != null) {
      // ចាប់យក Object Books មកទុកប្រើប្រាស់លើ UI (បង្ហាញចំណងជើង ឬរូបភាពសៀវភៅ)
      selectedBook.value = Get.arguments as Books;
      
      // ទាញយកលីង PDF ពីសៀវភៅនោះ
      String? url = selectedBook.value?.bookPdf;

      if (url != null && url.isNotEmpty) {
        // បើមានលីង ហៅ Function ទាញយក file ភ្លាមៗ
        downloadAndSavePdf(url);
      } else {
        debugPrint("សៀវភៅនេះគ្មានលីង PDF ទេ");
        isLoading.value = false;
      }
    } else {
      debugPrint("គ្មានទិន្នន័យសៀវភៅត្រូវបានបោះមកឡើយ");
      isLoading.value = false;
    }
  }

  // Function សម្រាប់ទាញយក និងរក្សាទុក File PDF ទៅក្នុងទូរស័ព្ទ
  Future<void> downloadAndSavePdf(String url) async {
    try {
      isLoading.value = true;
      
      // កាត់យកឈ្មោះ file (ឧទហរណ៍៖ book_sample.pdf)
      final filename = url.substring(url.lastIndexOf("/") + 1);
      
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      
      await file.writeAsBytes(bytes, flush: true);
      
      // រក្សាទុក Path ដើមដើម្បីឱ្យ widget ផ្សេងយកទៅបើកមើល
      pdfPath.value = file.path;
      
    } catch (e) {
      debugPrint("Error loading PDF: $e");
    } finally {
      isLoading.value = false; 
    }
  }
}