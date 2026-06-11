import 'package:e_learning_mobile/app/modules/Library_online/controllers/library_online_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_screen_category_controller.dart';

class HomeScreenCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenCategoryController>(
      () => HomeScreenCategoryController(),
    );
    Get.lazyPut<LibraryOnlineController>(() => LibraryOnlineController());
  }
}
