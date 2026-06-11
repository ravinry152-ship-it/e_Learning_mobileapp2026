// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/login.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Login Form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(25),
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                     Text(
                      "សូមស្វាគមន៏ការត្រឡប់មកវិញ",
                      style:GoogleFonts.kantumruyPro(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                     Text(
                      "ចូលគណនីទៅកាន់គណនីរបស់អ្នក",
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const SizedBox(height: 20),

                    TextField(
                      controller: controller.controllerEmail,
                      decoration: InputDecoration(
                        labelText: "អីម៉ែល",
                        labelStyle: GoogleFonts.kantumruyPro(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    Obx((){
                   return TextField(
                      controller: controller.controllerPassword,
                     obscureText: controller.isHidden.value,
                      decoration: InputDecoration(
                        labelText: "ពាក្យសម្ងាត់",
                        labelStyle: GoogleFonts.kantumruyPro(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                       icon: Icon(
                       controller.isHidden.value ?
                        Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                      ),
                         onPressed: () {
                           controller.togglePasswordVisibility();
                         },
                         color: Colors.black,
                       ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                   }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Obx((){
                      return ElevatedButton(
                        onPressed: controller.isLoading.value
                        ?null
                        :()=>controller.login(),
                        child:controller.isLoading.value
                        ?SizedBox(
                          width: 25,
                          height: 25,
                         child: CircularProgressIndicator(
                           strokeWidth: 3,
                          color: Colors.white,
                         ),
                        )
                       : Text(
                          "ចូលគណនី",
                          style: GoogleFonts.kantumruyPro(fontSize: 18,fontWeight:FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      );
                        })
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            "ភ្លេចពាក្យសម្ងាត់?",
                            style: GoogleFonts.kantumruyPro(
                              color: Colors.red,
                              fontWeight:FontWeight.bold 
                            ),
                          ),

                        ),
                        TextButton(
                          onPressed: () {
                             Get.toNamed('/signup');
                          },
                          child:  Text("ចុះឈ្មោះ", style: GoogleFonts.kantumruyPro(color: Colors.blue, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}