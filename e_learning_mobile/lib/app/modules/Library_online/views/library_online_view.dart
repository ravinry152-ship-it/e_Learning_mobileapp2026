import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/library_online_controller.dart';

class LibraryOnlineView extends StatelessWidget {
  LibraryOnlineView({super.key});
  final con =Get.put(LibraryOnlineController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF0E2CB1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "បណ្ណាល័យអេឡិចត្រូនិច",
                    style: GoogleFonts.kantumruyPro(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "មានតែចំណេះវិជ្ជាទេដែលអាចជួយអ្នកឪ្យល្អប្រសេីបាន",
                    style: GoogleFonts.kantumruyPro(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SEARCH BAR
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "ស្វែងរកសៀវភៅ...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= CATEGORIES (REACTIVE) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                return Row(
                  children: List.generate(
                    con.filterChips.length,
                    (index) {
                      final isSelected =
                          con.selectedFilterIndex.value == index;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            con.changeFilterIndex(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0E2CB1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFF0E2CB1),
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                con.filterChips[index],
                                style: GoogleFonts.kantumruyPro(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // ================= TITLE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "សៀវភៅទាំងអស់",
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= SELECTED CATEGORY INFO =================
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Selected: ${con.filterChips[con.selectedFilterIndex.value]}",
                  style: GoogleFonts.kantumruyPro(
                    color: Colors.grey,
                  ),
                ),
              );
            }),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}