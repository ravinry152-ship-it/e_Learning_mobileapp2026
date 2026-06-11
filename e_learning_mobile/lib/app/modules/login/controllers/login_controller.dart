import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:e_learning_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  
  var isLoading = false.obs;
  var isHidden = true.obs;

  void togglePasswordVisibility() {
    isHidden.value = !isHidden.value;
  }

  //  លុបទិន្នន័យពីប្រអប់បញ្ចូលពេល Login ជោគជ័យ
  void _clearForm() {
    controllerEmail.clear();
    controllerPassword.clear();
  }

  // ============= fetch api login ====================
  Future<void> login() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('សូមបញ្ចូលអ៊ីមែល និងលេខសម្ងាត់');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showErrorDialog('ទម្រង់អ៊ីមែលមិនត្រឹមត្រូវទេ');
      return;
    }

    isLoading.value = true;
    try {
      Map<String, dynamic> loginData = {
        'email': email,
        'password': password,
      };

      final response = await apiProvider.post('/login/', data: loginData);

      if (response.statusCode == 200) {
        final resBody = response.data;
        final box = GetStorage();

        if (resBody['access'] != null) {
          await box.write('access_token', resBody['access']);
          box.write('refresh_token', response.data['refresh']);
          
          _showSuccessSnackbar();
          _clearForm(); 
          
          Get.offAllNamed(Routes.HOME_SCREEN_CATEGORY);
        } else {
          _showErrorDialog('មិនមាន Token ត្រឹមត្រូវពី Server');
        }
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      debugPrint("Login Error: $data");

      String errorMsg = 'អ៊ីមែល ឬលេខសម្ងាត់មិនត្រឹមត្រូវឡើយ';
      
      // ចាប់យកសារ error ពិតប្រាកដដែលសរសេរជាភាសាខ្មែរចេញពី Django views.py
      if (data is Map) {
        errorMsg = data['error']?.toString() ?? data['detail']?.toString() ?? errorMsg;
      }
      _showErrorDialog(errorMsg);
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorDialog(String message) {
    Get.defaultDialog(
      title: 'បញ្ហា!',
      titleStyle: GoogleFonts.kantumruyPro(color: Colors.red, fontWeight: FontWeight.bold),
      middleText: message,
      middleTextStyle: GoogleFonts.kantumruyPro(color: Colors.black, fontWeight: FontWeight.w500),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: Text("យល់ព្រម", style: GoogleFonts.kantumruyPro()),
      ),
    );
  }

  void _showSuccessSnackbar() {
    Get.snackbar(
      '', '',
      backgroundColor: const Color.fromARGB(255, 92, 169, 96),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      titleText: Text('ចូលប្រើប្រាស់ជោគជ័យ', style: GoogleFonts.kantumruyPro(color: Colors.white, fontWeight: FontWeight.bold)),
      messageText: Text('សូមស្វាគមន៍មកកាន់កម្មវិធីចំណេះថ្មីៗ', style: GoogleFonts.kantumruyPro(color: Colors.white)),
    );
  }

  @override
  void onClose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.onClose();
  }
}