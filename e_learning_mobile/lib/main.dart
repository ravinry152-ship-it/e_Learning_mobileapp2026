import 'package:e_learning_mobile/app/modules/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
   await Get.putAsync<ApiProvider>(() async => ApiProvider());
  
  final box = GetStorage();
  String? token = box.read('access_token');
  
  //ឆែកលក្ខខណ្ឌ៖ បើមាន token ឱ្យទៅ HomeProduct បើអត់ទេឱ្យទៅ Login
  // ignore: unused_local_variable
  String initialScreen = (token != null && token.isNotEmpty) ? Routes.HOME_SCREEN_CATEGORY : Routes.HOME;
  
  FlutterNativeSplash.remove();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: initialScreen,
      getPages: AppPages.routes,
    ),
  );
}
