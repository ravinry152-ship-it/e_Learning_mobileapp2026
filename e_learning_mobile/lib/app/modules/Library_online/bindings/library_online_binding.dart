import 'package:get/get.dart';

import '../controllers/library_online_controller.dart';

class LibraryOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LibraryOnlineController>(
      () => LibraryOnlineController(),
    );
  }
}
