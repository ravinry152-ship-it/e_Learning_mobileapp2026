import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/modules/model/book_model.dart';
import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Response;

class LibraryOnlineController extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  RxList<Books> booksList = <Books>[].obs;
  var searchbook =<Books>[].obs;
  // បង្កើត Map ដើម្បីភ្ជាប់ឈ្មោះខ្មែរ ទៅនឹង ID ពិតប្រាកដនៅក្នុង Django Database
  final List<Map<String, dynamic>> filterChips = [
    {'name': 'ទាំងអស់', 'id': null},       
    {'name': 'បច្ចេកវិទ្យា', 'id': 1},    
    {'name': 'កសិកម្ម', 'id': 2},       
    {'name': 'ចំណេះដឹងទូទៅ', 'id': 3},   
  ];

  final RxInt selectedFilterIndex = 0.obs;
  RxBool isLoading = false.obs;

  void changeFilterIndex(int index) {
    if (index >= 0 && index < filterChips.length) {
      selectedFilterIndex.value = index;
      fetchbook(); 
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchbook();
  }

  Future<void> fetchbook() async {
    try {
      isLoading.value = true;
      booksList.clear();

      // ចាប់យក ID នៃប្រភេទដែលបានជ្រើសរើស
      final selectedId = filterChips[selectedFilterIndex.value]['id'];
      
      Response response;

      if (selectedId == null) {
        response = await api.get('/book/');
        if (response.statusCode == 200 && response.data != null) {
          final List<dynamic> data = response.data;
          // ដោយសារ /book/ ធម្មតាផ្ញើមកជា List នៃសៀវភៅត្រង់ៗ យើងបំប្លែងយកតែម្តង
          booksList.assignAll(data.map((json) => Books.fromJson(json)).toList());
          searchbook.assignAll(booksList);
        }
      } else {
        // កាលណាចុចប្រភេទជាក់លាក់៖ ហៅទៅកាន់ URL មាន ID ដូចជា /book/1/
        response = await api.get('/book/$selectedId/');
        if (response.statusCode == 200 && response.data != null) {
          // បំប្លែងទៅជា BookModel (ថ្នាក់ Category) រួចទាញយកអារេ 'books' មកប្រើ
          final BookModel categoryData = BookModel.fromJson(response.data);
          if (categoryData.books != null) {
            booksList.assignAll(categoryData.books!);
          }
        }
      }
      
      debugPrint("ទាញបានសៀវភៅចំនួន៖ ${booksList.length} ក្បាល");
      
    } on DioException catch (e) {
      debugPrint("Error fetching books: [${e.response?.statusCode}] -> ${e.response?.data}");
      booksList.clear();
    } finally {
      isLoading.value = false;
    }
  }
  //=================================searchbook===================================
  void searchBook(String query) {
    if (query.isEmpty) {
      searchbook.assignAll(booksList);
    } else {
      final searchInput = query.toLowerCase();
      final results = booksList.where((book) {
        final title = (book.title ?? '').toLowerCase();
        final description = (book.title ?? '').toLowerCase();
        return title.contains(searchInput) || description.contains(searchInput);
      }).toList();

      searchbook.assignAll(results);
    }
  }
}