import 'package:get/get.dart';

import '../controllers/view_book_controller.dart';

class ViewBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewBookController>(
      () => ViewBookController(),
    );
  }
}
