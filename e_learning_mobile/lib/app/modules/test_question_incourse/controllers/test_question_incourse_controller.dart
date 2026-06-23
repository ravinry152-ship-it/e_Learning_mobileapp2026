import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_package; 

class TestQuestionIncourseController extends GetxController {
  final ApiProvider apiProvider = Get.find<ApiProvider>();
  final isLoading = false.obs;
  final questions = <dynamic>[].obs;
  final currentQuestionIndex = 0.obs;
  final selectedAnswer = RxnInt();
  final Map<int, int> studentAnswers = <int, int>{}.obs;

  int lessonId = 1;

  @override
  void onInit() {
    super.onInit();
      lessonId = Get.arguments['lesson_id'];
      fetchQuestions(lessonId);
  }


  Future<void> fetchQuestions(int id) async {
    try {
      isLoading.value = true;
      final dio = dio_package.Dio();
      final String fullUrl = 'http://10.0.2.2:8000/api/question/';   
      final response = await dio.get(
        fullUrl, 
        queryParameters: {'lesson_id': id}
      );

      if (response.statusCode == 200 && response.data != null) {
        questions.assignAll(response.data);
      }
    } catch (e) {
      Get.snackbar('កំហុស', 'មិនអាចទាញយកទិន្នន័យសំណួរពីម៉ាស៊ីនបម្រើបានទេ');
    } finally {
      isLoading.value = false;
    }
  }

  // ==============================================================================
  // ២. មុខងារជ្រើសរើសចម្លើយ និងកត់ត្រាទុកក្នុង Memory
  // ==============================================================================
  void selectAnswer(int choiceId) {
    if (questions.isEmpty) return;
    
    selectedAnswer.value = choiceId;
    int currentQuestionId = questions[currentQuestionIndex.value]['id'];
    studentAnswers[currentQuestionId] = choiceId;
  }

  // ==============================================================================
  // ៣. មុខងារទៅកាន់សំណួរបន្ទាប់ ឬចុច Submit
  // ==============================================================================
  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      
      int nextQuestionId = questions[currentQuestionIndex.value]['id'];
      selectedAnswer.value = studentAnswers[nextQuestionId];
    } else {
      submitQuiz();
    }
  }
  // ===========================skipQuestion====================================
  void skipQuestion(){
    if (questions.isEmpty) return;

    int currentQuestionId = questions[currentQuestionIndex.value]['id'];
    
    
    if (!studentAnswers.containsKey(currentQuestionId)) {
      studentAnswers[currentQuestionId] = 0; 
    }

    // ប្តូរទៅសំណួរបន្ទាប់
    nextQuestion();
  }

  // ==============================================================================
  // ៤. មុខងារផ្ញើចម្លើយទៅគណនាពិន្ទុនៅលើ Backend (Submit)
  // ==============================================================================
 Future<void> submitQuiz() async {
    // ការពារករណីសិស្សមិនទាន់បានឆ្លើយសូម្បីតែមួយសំណួរ
    if (studentAnswers.isEmpty) {
      Get.snackbar('បញ្ជាក់', 'សូមឆ្លើយសំណួរយ៉ាងហោចណាស់ឱ្យបាន ១ មុននឹងផ្ញើលទ្ធផល');
      return;
    }

    try {
      isLoading.value = true;

      List<Map<String, int>> formattedAnswers = [];
      studentAnswers.forEach((qId, cId) {
        formattedAnswers.add({
          "question_id": qId,
          "choice_id": cId,
        });
      });

      final requestData = {
        "lesson_id": lessonId, 
        "answers": formattedAnswers
      };

      final response = await apiProvider.post(
        '/submite/', 
        data: requestData, 
      );
      if (response.statusCode == 200 || response.statusCode == 201 && response.data != null) {
        Get.offNamed('/quiz-result', arguments: response.data);
      } else {
        Get.snackbar('បញ្ជាក់', 'ការផ្ញើចម្លើយមិនជោគជ័យឡើយ');
      }
    } catch (e) {
      Get.snackbar('កំហុស', 'ការផ្ញើចម្លើយទៅកាន់ម៉ាស៊ីនបម្រើមានបញ្ហា');
    } finally {
      isLoading.value = false;
    }
  }
}