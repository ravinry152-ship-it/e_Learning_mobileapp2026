import 'package:get/get.dart';

class LibraryOnlineController extends GetxController {
  final List<String> filterChips = [
    'Design',
    'Software',
    'Network',
    'Marketing',
  ];

  final RxInt selectedFilterIndex = 0.obs;

  void changeFilterIndex(int index) {
    if (index >= 0 && index < filterChips.length) {
      selectedFilterIndex.value = index;
    }
  }
}