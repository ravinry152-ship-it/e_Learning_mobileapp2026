// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/welcome_screen_controller.dart';

class WelcomeScreenView extends GetView<WelcomeScreenController> {
  const WelcomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset("assets/image/login.jpg",fit: BoxFit.cover, ),
          ),

          // Dark Overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // Content
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  "សូមធ្វេីការចុះឈ្មោះ ឬចូលគណនី ដេីម្បីចូលទៅកាន់កម្មវិធីសិក្សា",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kantumruyPro(
                    color: const Color.fromARGB(255, 224, 217, 217),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                 Text(
                  "សូមស្វាគមន៍មកកាន់កម្មវិធីសិក្សា",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kantumruyPro(
                    color: const Color.fromARGB(179, 255, 255, 255),
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                     Get.toNamed('/login');
                    },
                    child:  Text(
                      "ចូលគណនី",
                      style: GoogleFonts.kantumruyPro(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child:  Text(
                      "ចុះឈ្មោះ",
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}