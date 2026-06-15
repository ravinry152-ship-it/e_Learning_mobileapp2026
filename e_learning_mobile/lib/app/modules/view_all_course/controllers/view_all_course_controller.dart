//import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/home_screen_category/controllers/home_screen_category_controller.dart';
import 'package:e_learning_mobile/app/modules/model/course_model.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;

class ViewAllCourseController extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  //list store  all course
  RxList<FullCourses> course = <FullCourses>[].obs;
  final List<Map<String, dynamic>> filterChips = [
    {'name' : 'ទាំងអស់', 'id': null},
    {'name' : 'បច្ចេកវិទ្យា', 'id':1 },
    {'name' : 'កសិកម្ម', 'id':2 },
    {'name' : 'ជំនាញបច្ចេកទេស', 'id': 3},
    {'name' : 'ចំណេះដឹងទូទៅ', 'id':4 },
    ];
  final c= Get.find<HomeScreenCategoryController>();
  var selectedFilterIndex = 0.obs;
  RxBool isLoading = false.obs;
  // Function សម្រាប់ផ្លាស់ប្តូរ Filter
  void changeFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }
  // ========function start app=========
  @override
  void onInit() {
    super.onInit();
    fetchcourse();
  }
  //=================fetch course========================
  Future<void> fetchcourse() async{
    try{
    isLoading.value = true;
    course.clear();
   final selectedId = filterChips[selectedFilterIndex.value]['id'];

    Response response;

    if (selectedId == null) {
      response = await api.get('/courses/');
      if (response.statusCode == 200 && response.data != null) {
        
        // បំប្លែង response.data ដែលជា Map ទៅជា Object នៃ Class Data សិន
        final Data responseData = Data.fromJson(response.data);
        
        //  ទាញយក list fullCourses ពីក្នុង responseData នោះមកប្រើ
        if (responseData.fullCourses != null) {
          course.assignAll(responseData.fullCourses!);
          debugPrint("លទ្ធផលទាញយកវគ្គសិក្សាទាំងអស់បាន៖ ${course.length} វគ្គ");
        } else {
          course.clear();
          debugPrint("រកមិនឃើញ key 'full_courses' នៅក្នុងទិន្នន័យទេ");
        }
      }
    }else{
      response = await api.get('/courses/$selectedId/');
      if(response.statusCode ==200 && response.data != null){
        // បំប្លែងទៅជា BookModel (ថ្នាក់ Category) រួចទាញយកអារេ 'course' មកប្រើ
          final Data categoryData = Data.fromJson(response.data);
          if (categoryData.fullCourses != null) {
            course.assignAll(categoryData.fullCourses!);
          }
      }
    }

    }on DioException catch (e) {
      debugPrint("Error fetching books: [${e.response?.statusCode}] -> ${e.response?.data}");
      course.clear();
    } finally {
      isLoading.value = false;
    }

  }
  }