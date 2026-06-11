// ignore_for_file: non_constant_identifier_names
import 'package:e_learning_mobile/app/modules/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_screen_category_controller.dart';

class HomeScreenCategoryView extends GetView<HomeScreenCategoryController> {
  const HomeScreenCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 222, 222),
      body: Obx(() {
        if (controller.currentIndex.value == 0) {
          return RefreshIndicator(
            onRefresh: () async => controller.fetchCourse(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 101, 112, 234),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(35),
                          ),
                        ),
                        height: 230, 
                        width: double.infinity,
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                  children: [
                                     Text(
                                      controller.greeting,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 201, 192, 192), 
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed('/notification');
                                      }, 
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                   "សួស្តី ${controller.username.value}",
                                  style: GoogleFonts.kantumruyPro(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold, 
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  onChanged: (value) => 
                                  controller.searchCourse(value),
                                  decoration: InputDecoration(
                                    hintText: "ស្វែងរកមេរៀន",
                                    hintStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "មេរៀនពេញនិយម",
                          style: GoogleFonts.kantumruyPro(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                           Get.toNamed('/view-all-course');
                          }, 
                          child: Text(
                            "មេីលទាំងអស់",
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildcourselist() // បង្ហាញ Grid ទិន្នន័យ
                ],
              ),
            ),
          );
        } else {
          return controller.screens[controller.currentIndex.value];
        }
      }),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value, 
          onTap: (index) {
            controller.changePage(index); 
          },
          selectedItemColor: const Color.fromARGB(255, 101, 112, 234),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ដេីម'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'បណ្ណាល័យ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'គណនី'),
          ],
        ),
      ),
    );
  }

  Widget _buildcourselist() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }
    
      if (controller.searchcurse.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(child: Text("មិនមានទិន្នន័យអំពីវក្គសិក្សា")),
        );
      }
      
      final Data currentData = controller.searchcurse[0];
      final List<FullCourses> courseList = currentData.fullCourses ?? [];
    
      if (courseList.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(top: 190),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text(
              "មិនមានទិន្នន័យអំពីវក្គសិក្សា",
            
              )),
          ),
        );
      }
      
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.90, 
        ),
        itemCount: courseList.length >8 ?8 : courseList.length, 
        itemBuilder: (context, index) {
          final FullCourses singleCourse = courseList[index]; 
          return _Course(singleCourse); 
        },
      );
    });
  }

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