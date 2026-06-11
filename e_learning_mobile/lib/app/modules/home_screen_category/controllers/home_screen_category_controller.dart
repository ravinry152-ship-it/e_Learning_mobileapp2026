import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/Library_online/views/library_online_view.dart';
import 'package:e_learning_mobile/app/modules/model/course_model.dart';
import 'package:e_learning_mobile/app/modules/profile/views/profile_view.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenCategoryController extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  var username = "Student".obs;
  var currentIndex = 0.obs;
  //list store search coruse
  var searchcurse = <Data>[].obs;
  RxBool isLoading = false.obs;
  RxList<Data> product = <Data>[].obs; 
//List  change screen  button navigation bar
  final List<Widget> screens = [
    Container(), 
    LibraryOnlineView(),
    ProfileView()
  ];
//  Greeting តាមពេលវេលា
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "Good morning";
    if (hour >= 12 && hour < 18) return "Good afternoon";
    return "Good evening";
  }
// function  change screen
  void changePage(int index) {
    currentIndex.value = index;
  }
// function  start app
  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchCourse(); 
  }

  // ========================= fetch courses ======================
  Future<void> fetchCourse() async {
    try {
      isLoading.value = true;

      final response = await api.get('/courses/');

      if (response.statusCode == 200 && response.data != null) {
        product.clear();
        product.add(Data.fromJson(response.data));
        //search course
        searchcurse.assignAll(product);
        debugPrint(" Fetch Courses Success");
      }
    } on DioException catch (e) {
      debugPrint(" Error fetching courses: [${e.response?.statusCode}] -> ${e.response?.data}");
      product.clear();
      searchcurse.clear();
    } catch (e) {
      debugPrint(" General Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ========================= fetch username ======================
  Future<void> fetchUserProfile() async {
    try {
      final response = await api.get('/profile/'); 

      if (response.statusCode == 200 && response.data != null) {
        username.value = response.data['username'] ?? "User";
        debugPrint(" Profile Name: ${username.value}");
      }
    } on DioException catch (e) {
      debugPrint(" Error fetching profile: [${e.response?.statusCode}]");
      username.value = "Guest"; 
    } catch (e) {
      username.value = "Guest";
    }
  }

  // ==================== Search Product ====================
  void searchCourse(String query) {
    if (query.isEmpty) {
      searchcurse.assignAll(product);
    } else {
      if (product.isNotEmpty && product[0].fullCourses != null) {
        var results = product[0].fullCourses!.where((course) {
          final description = (course.courseDescription ?? '').toLowerCase();
          final searchInput = query.toLowerCase();
          return description.contains(searchInput);
        }).toList();

        searchcurse.assignAll([Data(fullCourses: results)]);
      }
    }
  }
}