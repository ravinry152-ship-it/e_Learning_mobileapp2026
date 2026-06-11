import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image:  DecorationImage(
                    image: AssetImage("assets/image/home.jpg"),
                    fit: BoxFit.contain, 
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 121, 112, 182), 
                  borderRadius: BorderRadius.circular(32), 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        "សូមស្វាគមន៍មកកាន់កម្មវិធីសិក្សា\nបច្ចេកវិទ្យា កសិកម្ម និងចំណេះដឹងទូទៅ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kantumruyPro(
                          color: const Color(0xFF2D0C57), 
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),

                    Flexible(
                      child: Text(
                        "ស្វែងរកចំណេះដឹងថ្មីៗជារៀងរាល់ថ្ងៃ ដើម្បីអភិវឌ្ឍសមត្ថភាពរបស់អ្នកឱ្យកាន់តែប្រសើរឡើង។",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 4, 4, 4),
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/welcome-screen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5635B0), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "ចាប់ផ្តើមសិក្សា",
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}