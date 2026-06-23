// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB), 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'ការជូនដំណឹង',
          style: GoogleFonts.kantumruyPro(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF5C2D91),
            ),
          );
        }
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text(
              'មិនមានការជូនដំណឹងទេ',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notificationItem = controller.notifications[index];
            return _NotificationWidget(notificationItem);
          },
        );
      }),
    );
  }
  Widget _NotificationWidget(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: const Color(0xFF5C2D91).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_active_rounded,
            color: Color(0xFF5C2D91),
            size: 24,
          ),
        ),
        title: Text(
          item['title'] ?? 'គ្មានចំណងជើង',
          style: GoogleFonts.kantumruyPro(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item['description'] ?? 'គ្មានការពិពណ៌នាឡើយ',
            style: GoogleFonts.kantumruyPro(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}