import 'package:get/get.dart';

import '../controllers/test_question_incourse_controller.dart';

class TestQuestionIncourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestQuestionIncourseController>(
      () => TestQuestionIncourseController(),
    );
  }
}
