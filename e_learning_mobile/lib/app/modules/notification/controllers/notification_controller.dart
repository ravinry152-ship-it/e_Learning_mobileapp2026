import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NotificationController extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  final unreadNotificationsCount = 0.obs;
  final isLoading = false.obs;
final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;  @override
  void onInit() {
    super.onInit();
    fetchNotification(); 
  }

  Future<void> fetchNotification() async {
  try {
    isLoading.value = true;
    final response = await api.get("/notification/"); 

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data;
    //data is List មានន័យថា៖ "តើទិន្នន័យដែលផ្ញើមកពី Server 
    //មានទម្រង់ជាប្រភេទ List (Array [...]) មែនដែរឬទេ
      notifications.assignAll(data is List ?
       List<Map<String, dynamic>>.from(data) : [Map<String, dynamic>.from(data)]);
       unreadNotificationsCount.value = notifications.length;
    }
  } catch (e) {
    debugPrint("Error loading data in Controller: $e");
  } finally {
    isLoading.value = false;
  }
}
//===================notification =======================
  void clearNotificationBadge() {
  unreadNotificationsCount.value = 0;
}
}
