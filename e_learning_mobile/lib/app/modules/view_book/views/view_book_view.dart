import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/view_book_controller.dart';

class ViewBookView extends GetView<ViewBookController> {
  const ViewBookView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ViewBookView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ViewBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
