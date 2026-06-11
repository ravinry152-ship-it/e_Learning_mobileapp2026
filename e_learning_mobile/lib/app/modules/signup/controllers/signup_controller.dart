import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:e_learning_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  
  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  
  var isLoading = false.obs;
  var isHidden = true.obs;

  void togglePasswordVisibility() {
    isHidden.value = !isHidden.value;
  }

  void _clearForm() {
    controllerUsername.clear();
    controllerEmail.clear();
    controllerPassword.clear();
  }

  //========== fetch api signup ========================
  Future<void> signup() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorDialog('សូមបំពេញព័ត៌មានទាំងអស់');
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showErrorDialog('Email មិនត្រឹមត្រូវ');
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiProvider.post(
        '/register/',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final box = GetStorage();
        final resBody = response.data;
        if (resBody['access'] != null) {
          await box.write(
            'access_token',
            resBody['access'], // រក្សាទុក Access Token ចូល GetStorage
          );
          box.write('refresh_token', response.data['refresh']);
          await box.write('username', username);

          _showSuccessSnackbar();
          _clearForm(); 
           Get.offAllNamed(Routes.HOME_SCREEN_CATEGORY);
        } else {
          _showErrorDialog('ការចុះឈ្មោះជោគជ័យ តែមិនទទួលបាន Token ពីម៉ាស៊ីនបម្រើទេ។');
        }
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      debugPrint("Signup Error: $data");

      String errorMsg = 'ការចុះឈ្មោះបរាជ័យ';
      
      if (data is Map) {
        errorMsg = data['error']?.toString() ?? 
        data['detail']?.toString() ?? errorMsg;
      }

      _showErrorDialog(errorMsg);
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorDialog(String message) {
    Get.defaultDialog(
      title: 'បញ្ហា!',
      titleStyle: GoogleFonts.kantumruyPro(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      middleText: message,
      middleTextStyle: GoogleFonts.kantumruyPro(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
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
      titleText: Text('ចុះឈ្មោះជោគជ័យ', style: GoogleFonts.kantumruyPro(color: Colors.white, fontWeight: FontWeight.bold)),
      messageText: Text('សូមស្វាគមន៍មកកាន់កម្មវិធីចំណេះថ្មីៗ', style: GoogleFonts.kantumruyPro(color: Colors.white)),
    );
  }

  @override
  void onClose() {
    controllerUsername.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.onClose();
  }
}