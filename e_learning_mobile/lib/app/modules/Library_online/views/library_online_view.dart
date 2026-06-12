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
                    "មានតែចំណេះវិជ្ជាទេដែលអាចជួយឪ្យជីវិតអ្នកល្អប្រសេីបាន",
                    style: GoogleFonts.kantumruyPro(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
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

            const SizedBox(height: 30),

            // ================= CATEGORIES (REACTIVE) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(
                    con.filterChips.length,
                    (index){
                      final isSelected = con.selectedFilterIndex.value == index;
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xFF0E2CB1) : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ?const Color(0xFF0E2CB1) : const Color(0xFFE2E8F0),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                         ? [
                         BoxShadow(
                        // ignore: deprecated_member_use
                        color: const Color(0xFF0E2CB1).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                        )
                        ]
                       : [],
                          ),
                          child: InkWell(
                            onTap: (){
                              con.changeFilterIndex(index);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Center(
                                child: Text(
                                  con.filterChips[index]['name'],
                                  style: GoogleFonts.kantumruyPro(
                                    fontWeight: isSelected?FontWeight.w700 : FontWeight.w500,
                                    fontSize: 14,
                                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                              ),
                          ),
                          ),

                        );
                    }
                    )
                  ),
                );
              }),
            ),

            const SizedBox(height: 26),

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
              if(con.isLoading.value){
                return Center(
                 child: CircularProgressIndicator(color:Color(0xFF0E2CB1) ,),
                );
              }
              if(con.booksList.isEmpty){
                return Center(
                child: Text(
                "មិនមានសៀវភៅក្នុងប្រភេទនេះទេ",
                 style: GoogleFonts.kantumruyPro(color: Colors.grey),
              ),
              );
              }
              return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.90
                ) , 
              itemCount: con.booksList.length,
              itemBuilder: (context, index){
                final item=con.booksList[index];
                return Container(
              decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
         child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
           borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
            child: item.image != null && item.image!.isNotEmpty
             ? ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              item.image!,
              fit: BoxFit.cover,
              // បង្ហាញវង់មូល Loading រង់ចាំរូបភាពមកដល់
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                );
              },
            ),
          )
          : const Center(
            child: Icon(Icons.book, size: 50, color: Color(0xFF0E2CB1)),
          ),
           ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ចំណងជើងសៀវភៅ
                  Text(
                    item.title ?? "គ្មានចំណងជើង",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                    style: GoogleFonts.kantumruyPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      }
      );
      }),
    const SizedBox(height: 30),
      ],
      ),
      ),
    );
  }
}