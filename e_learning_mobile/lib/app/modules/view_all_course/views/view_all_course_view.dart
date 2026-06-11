// ignore_for_file: non_constant_identifier_names, deprecated_member_use
import 'package:e_learning_mobile/app/modules/home_screen_category/controllers/home_screen_category_controller.dart';
import 'package:e_learning_mobile/app/modules/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/view_all_course_controller.dart';

class ViewAllCourseView extends GetView<ViewAllCourseController> {
   ViewAllCourseView({super.key});
// Register or retrieve the controller instance. Use Get.put to return the instance
final c = Get.put(ViewAllCourseController());
final con = Get.find<HomeScreenCategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 102, 129, 175),
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          "មេីលវគ្គសិក្សាទាំងអស់", 
          style: GoogleFonts.kantumruyPro(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (con.currentIndex.value == 0) {
          return RefreshIndicator(
            onRefresh: () async => con.fetchCourse(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ប្រភេទវគ្គសិក្សា',
                        style: GoogleFonts.kantumruyPro(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _FilterChipsRow(controller: c),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: 20,),
                  _buildcourselist()
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
  //==================widet course list=======================
  Widget  _buildcourselist(){
    return Obx((){
      if(con.isLoading.value){
        return Padding(
          padding:EdgeInsets.all(20),
          child: Center(child: CircularProgressIndicator()),
           );
      }
      if(con.product.isEmpty){
        return Padding(
           padding: EdgeInsets.only(top: 50, left: 40),
           child: Center(child: Text("មិនមានទិន្នន័យអំពីវក្គសិក្សា")),
           );
      }
       final Data currentData = con.product[0];
      final List<FullCourses> courseList = currentData.fullCourses ?? [];
      if(courseList.isEmpty){
        return Padding(
           padding: EdgeInsets.only(top: 200, left: 120),
          child: Text(
            "មិនមានទិន្នន័យអំពីវក្គសិក្សា",
            style: GoogleFonts.kantumruyPro(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
          ),
           );
      }
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.90
           ),
         itemCount: courseList.length, 
        itemBuilder: (context, index){
        final FullCourses course = courseList[index]; 
        return _Course(course);
        }
        );
    });
  }
  //=====================widget course=========================
 Widget _Course(FullCourses product) {
    String imageUrl = "";
    
    if (product.image != null && product.image!.isNotEmpty) {
      if (product.image!.startsWith('http')) {
        imageUrl = product.image!;
      } else {
        String cleanPath = product.image!.startsWith('/') 
            ? product.image!.substring(1) 
            : product.image!;     
        if (cleanPath.startsWith('media/')) {
          imageUrl = "http://10.0.2.2:8000/$cleanPath";
        } else {
          imageUrl = "http://10.0.2.2:8000/media/$cleanPath";
        }
      }
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed('/view-course-detail', arguments: product.id);
      },
      child: Card(
        elevation: 19,
        shadowColor: Colors.black12,
        color: const Color.fromARGB(255, 255, 249, 249),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain, 
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint(" លីងរូបភាពដែលខុស៖ $imageUrl");
                            return const Icon(Icons.broken_image, size: 40, color: Colors.redAccent);
                          },
                        ),
                      )
                    : const Icon(Icons.image, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Text(
                  product.courseDescription ?? "No Description",
                  style: GoogleFonts.kantumruyPro(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ប្តូរពី StatefulWidget មកជា StatelessWidget វិញដើម្បីកាត់បន្ថយទម្ងន់កូដ
class _FilterChipsRow extends StatelessWidget {
  final ViewAllCourseController controller;
  const _FilterChipsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // ទាញយក list filterChips ពី controller មកប្រើ
        children: List.generate(controller.filterChips.length, (index) {
          return Obx(() {
            // ប្រើ Obx ដើម្បីស្តាប់ការផ្លាស់ប្តូរ selectedFilterIndex
            final isSelected = controller.selectedFilterIndex.value == index;
            
            return GestureDetector(
              onTap: () => controller.changeFilterIndex(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF5C2D91) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF5C2D91) : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF5C2D91).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : [],
                ),
                child: Text(
                  controller.filterChips[index],
                  style: GoogleFonts.kantumruyPro(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}