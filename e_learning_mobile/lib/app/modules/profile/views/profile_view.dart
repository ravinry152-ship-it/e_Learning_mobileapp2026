// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:e_learning_mobile/app/modules/home_screen_category/controllers/home_screen_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
 // ignore: annotate_overrides
 final ProfileController controller =
      Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeScreenCategoryController>();
    final box = GetStorage();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Profile Image
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Obx(
                      () => CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.green.shade300,
                        backgroundImage:
                            controller.imagePath.value.isNotEmpty
                                ? FileImage(
                                    File(controller.imagePath.value),
                                  )
                                : const NetworkImage(
                                        'https://via.placeholder.com/150')
                                    as ImageProvider,
                        child: controller.imagePath.value.isEmpty
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 35,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 25),
              /// Username
              Obx(
                () => Text(
                  "Hello, ${homeController.username.value}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Divider(),

              const SizedBox(height: 30),

              /// Language Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.updateLocale(
                          const Locale('km', 'KH'),
                        );
                      },
                      icon: const Icon(Icons.language),
                      label: const Text("ខ្មែរ"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.updateLocale(
                          const Locale('en', 'US'),
                        );
                      },
                      icon: const Icon(Icons.language),
                      label: const Text("English"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              /// Logout Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    box.erase();
                    Get.defaultDialog(
                      title: "ចាកចេញពីគណនី",
                      titleStyle: GoogleFonts.kantumruyPro(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      middleText: "តេីអ្នកពិតជាចង់ចាកចេញពីគណនីមែនទេ",
                      middleTextStyle: GoogleFonts.kantumruyPro(
                        fontSize: 16,
                      ),
                      backgroundColor: Colors.white,
                      radius: 15,
                      confirm: ElevatedButton(
                        onPressed: () {
                          box.erase();
                          Get.back();
                        },
                        child: TextButton(onPressed:(){
                           Get.offAllNamed('/login');
                        },
                         child: Text(
                          "ចាកចេញ"
                          )
                        )
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('បោះបង់'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label:  Text(
                    "ចាកចេញ",
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}