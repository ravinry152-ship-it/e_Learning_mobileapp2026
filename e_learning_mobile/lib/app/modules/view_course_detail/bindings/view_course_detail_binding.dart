import 'package:get/get.dart';

import '../controllers/view_course_detail_controller.dart';

class ViewCourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewCourseDetailController>(
      () => ViewCourseDetailController(),
    );
  }
}
