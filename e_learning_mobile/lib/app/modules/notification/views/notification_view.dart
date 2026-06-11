import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'ការជូនដំណឹង',
          style:GoogleFonts.kantumruyPro(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
          ),
        centerTitle: true,
      ),
    );
  }
}
