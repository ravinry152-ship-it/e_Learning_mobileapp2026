import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/model/course_list.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewCourseDetailController extends GetxController {
  int? courseId;
  
  // បង្កើត RxString សម្រាប់ទុកបង្ហាញចំណងជើងវគ្គសិក្សាលើ UI
  RxString courseDescription = "".obs;

  final ApiProvider api = Get.find<ApiProvider>();
  
  RxList<VideoList> courselist = <VideoList>[].obs;
  RxBool isLoading = false.obs;
  
  YoutubePlayerController? youtubeController;
  var isVideoLoading = true.obs;
  var currentTab = 0.obs;
  var currentPlayingIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    
    courseId = Get.arguments as int?;
    // ហៅ API ឱ្យធ្លាក់ទិន្នន័យមកសិន ទើបបង្កើតផ្ទាំងចាក់វីដេអូតាមក្រោយ
    loadCourseData();
  }

  Future<void> loadCourseData() async {
    // ១. ហៅទាញយកវីដេអូពី API ឱ្យបានរួចរាល់សិន ដោយភ្ជាប់ជាមួយ courseId
    await fetchCourselist(courseId: courseId);
    
    // ទាញយកឈ្មោះវគ្គសិក្សាពីវីដេអូដំបូងដែលទាញបានមកបង្ហាញលើ UI
    if (courselist.isNotEmpty) {
      courseDescription.value = courselist[0].courseTitle ?? "Course Video";
    } else {
      courseDescription.value = "Course Video";
    }
    
    // ២. ក្រោយពី API ដើរចប់ ទើបយកវីដេអូទី១ ក្នុង List មកផ្ដើមចាក់បង្ហាញ
    initializeYoutubeVideo();
  }

  void initializeYoutubeVideo() {
    String? videoUrl;

    // បើ API មានបោះវីដេអូមក ត្រូវយកវីដេអូដំបូងគេ (Index 0) មកចាក់
    if (courselist.isNotEmpty) {
      videoUrl = courselist[0].videoUrl;
      currentPlayingIndex.value = 0;
    } 

    // បើសិនជាគ្មានវីដេអូមកពី API សោះ ដាក់លីង Default មួយសម្រាប់តេស្ត
    videoUrl ??= "https://www.youtube.com/watch?v=SNgNieAN_pg";

    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
      isVideoLoading.value = false;
    } else {
      debugPrint("Error: Can't convert YouTube URL to ID");
    }
  }

  void changeTab(int index) {
    currentTab.value = index;
  }

  @override
  void onClose() {
    youtubeController?.dispose();
    super.onClose();
  }

  //======================fetch course list========================
  Future<void> fetchCourselist({int? courseId}) async {
    try {
      isLoading.value = true;

      //  បង្កើតលីង URL ដោយបូកបញ្ចូល Parameter ផ្ទាល់ៗតែម្តង ដើម្បីធានាថាផ្ញើទៅ Django មិនបាត់បង់
      String url = '/courselist/';
      if (courseId != null) {
        url = '/courselist/?course_id=$courseId';
      }

      final response = await api.get(url); //  ហៅទៅលីងផ្ទាល់ដែលមានភ្ជាប់ ?course_id

      if (response.statusCode == 200 && response.data != null) {
        courselist.clear();

        final List<dynamic> rawData = response.data;
        for (var item in rawData) {
          courselist.add(VideoList.fromJson(item));
        }
        
        debugPrint(" Fetch ជោគជ័យ! ទទួលបានវីដេអូចំនួន៖ ${courselist.length} សម្រាប់ Course ID: $courseId");
      }
    } on DioException catch (e) {
      debugPrint("Error fetching videos: [${e.response?.statusCode}] -> ${e.response?.data}");
      courselist.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void playVideoAtIndex(int index) {
    if (index < 0 || index >= courselist.length) return;

    currentPlayingIndex.value = index;
    String? videoUrl = courselist[index].videoUrl;

    if (videoUrl != null) {
      String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
      if (videoId != null && youtubeController != null) {
        youtubeController!.load(videoId); 
      }
    }
  }
}