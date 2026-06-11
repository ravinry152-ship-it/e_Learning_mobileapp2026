import 'package:get/get.dart';

import '../controllers/view_all_course_controller.dart';

class ViewAllCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewAllCourseController>(
      () => ViewAllCourseController(),
    );
  }
}
