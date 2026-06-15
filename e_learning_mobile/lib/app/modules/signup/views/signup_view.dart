import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
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
                      "សូមស្វាគមន៏មកកាន់កម្មវិធីសាលាខ្មែរ(Sala KH)",
                      style:GoogleFonts.kantumruyPro(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                     Text(
                      "ចុះឈ្មោះគណនីរបស់អ្នកដេីម្បីចូលទៅកាន់កម្មវិធី",
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.grey,
                        fontSize:15
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller: controller.controllerUsername,
                      decoration: InputDecoration(
                        labelText: "ឈ្មោះអ្នកប្រេីប្រាស់",
                        labelStyle: GoogleFonts.kantumruyPro(fontWeight: FontWeight.bold,color:Colors.grey),
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

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
                      obscureText:controller.isHidden.value,
                      decoration: InputDecoration(
                        labelText: "ពាក្យសម្ងាត់",
                        labelStyle: GoogleFonts.kantumruyPro(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed:(){
                            controller.togglePasswordVisibility();
                          } ,
                           icon: Icon(
                            controller.isHidden.value ?
                            Icons.visibility_off_outlined : Icons.visibility_outlined,
                            size: 20,
                            color: Colors.black,
                           )
                           ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    );
                    }),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.signup(),
                          // ignore: sort_child_properties_last
                          child: controller.isLoading.value
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "ចុះឈ្មោះ",
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text("មិនទាន់មានគណនីទេ?",style:GoogleFonts.kantumruyPro(color: Colors.grey, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/login');
                          },
                          child:  Text("ចូលគណនី", style: GoogleFonts.kantumruyPro(color: Colors.blue, fontWeight: FontWeight.bold)),
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
