// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/view_course_detail_controller.dart';

class ViewCourseDetailView extends GetView<ViewCourseDetailController> {
  const ViewCourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //   បើ API កំពុងទាញទិន្នន័យ (isLoading) ឬ YoutubePlayer មិនទាន់រួចរាល់ ឱ្យវិល Loading សិន
      if (controller.isLoading.value || controller.youtubeController == null) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF5C2D91)),
          ),
        );
      }

      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.youtubeController!,
          aspectRatio: 16 / 9, 
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
                onPressed: () => Get.back(),
              ),
              title: Text(
                'Course Video',
                style: GoogleFonts.kantumruyPro(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ១. ផ្នែកចាក់វីដេអូ YouTube
                player,

                // ២. ផ្នែកព័ត៌មានខាងក្រោម (Tabs)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.courseDescription.value ,
                          style: GoogleFonts.kantumruyPro(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),

                        // Buttons Tab (Playlist / Description)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: controller.currentTab.value == 0 ? const Color(0xFF5C2D91) : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Playlist",
                                      style: GoogleFonts.kantumruyPro(
                                        color: controller.currentTab.value == 0 ? Colors.white : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => controller.changeTab(1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: controller.currentTab.value == 1 ? const Color(0xFF5C2D91) : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Description",
                                      style: GoogleFonts.kantumruyPro(
                                        color: controller.currentTab.value == 1 ? Colors.white : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ប្តូរការបង្ហាញតាម Tab
                        controller.currentTab.value == 0
                            ? _buildPlaylistSection()
                            : _buildDescriptionSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildPlaylistSection() {
    if (controller.courselist.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "មិនទាន់មានវីដេអូនៅក្នុងវគ្គសិក្សានេះទេ",
            style: GoogleFonts.kantumruyPro(color: Colors.grey),
          ),
        ),
      );
    }
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true, 
          physics: const NeverScrollableScrollPhysics(), 
          itemCount: controller.courselist.length,
          itemBuilder: (context, index) {
            final video = controller.courselist[index];
            
            return Obx((){
            final bool isCurrentPlaying = controller.currentPlayingIndex.value == index;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              color: isCurrentPlaying ? const Color(0xFF5C2D91).withOpacity(0.1) : Colors.grey.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () {
                  controller.playVideoAtIndex(index);
                },
                leading: Icon(
                  isCurrentPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, 
                  color: const Color(0xFF5C2D91), 
                  size: 36
                ),
                title: Text(
                  video.title ?? "No Title",
                  style: GoogleFonts.kantumruyPro(
                    fontWeight: isCurrentPlaying ? FontWeight.bold : FontWeight.normal,
                    color: isCurrentPlaying ? const Color(0xFF5C2D91) : Colors.black,
                  ),
                ),
                subtitle: Text(
                  video.duration ?? "00:00", 
                  style: GoogleFonts.kantumruyPro(color: Colors.grey, fontSize: 12)
                ),
                trailing: isCurrentPlaying 
                    ? const Icon(Icons.equalizer, color: Color(0xFF5C2D91)) 
                    : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ),
            );
             });
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Text(
      controller.courseDescription.value,
      style: GoogleFonts.kantumruyPro(fontSize: 14, color: Colors.grey.shade700, height: 1.6),
    );
  }
}