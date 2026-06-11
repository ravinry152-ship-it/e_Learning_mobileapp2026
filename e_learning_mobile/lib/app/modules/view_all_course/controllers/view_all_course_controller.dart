//import 'package:flutter/material.dart';
import 'package:e_learning_mobile/app/modules/home_screen_category/controllers/home_screen_category_controller.dart';
import 'package:get/get.dart';

class ViewAllCourseController extends GetxController {
  // បញ្ជីទិន្នន័យ Filter Chips
  final List<String> filterChips = ['All','Design', 'Software', 'Network', 'Marketing'];
  final c= Get.find<HomeScreenCategoryController>();
  // ចាប់យក Index ដែលបានជ្រើសរើស (Reactive Variable)
  var selectedFilterIndex = 0.obs;

  // Function សម្រាប់ផ្លាស់ប្តូរ Filter
  void changeFilterIndex(int index) {
    selectedFilterIndex.value = index;
    // if(index==0){
    //   c.fetchCourse();
    // } else {
    //   filteredCour.assignAll(
    //     searchcurse
    //         .where((c) => c.title!.toLowerCase().contains(query.toLowerCase()))
    //         .toList(),
    //   );
    // }
  }
  }