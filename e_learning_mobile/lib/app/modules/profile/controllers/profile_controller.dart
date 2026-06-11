import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadImage();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        imagePath.value = pickedFile.path;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userImage', pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
      );
    }
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    imagePath.value = prefs.getString('userImage') ?? '';
  }

  Future<void> removeImage() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('userImage');

    imagePath.value = '';
  }
}