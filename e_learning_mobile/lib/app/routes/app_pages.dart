import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_screen_category/bindings/home_screen_category_binding.dart';
import '../modules/home_screen_category/views/home_screen_category_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/view_all_course/bindings/view_all_course_binding.dart';
import '../modules/view_all_course/views/view_all_course_view.dart';
import '../modules/view_course_detail/bindings/view_course_detail_binding.dart';
import '../modules/view_course_detail/views/view_course_detail_view.dart';
import '../modules/welcome_screen/bindings/welcome_screen_binding.dart';
import '../modules/welcome_screen/views/welcome_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME_SCREEN,
      page: () => const WelcomeScreenView(),
      binding: WelcomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN_CATEGORY,
      page: () => HomeScreenCategoryView(),
      binding: HomeScreenCategoryBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_ALL_COURSE,
      page: () => ViewAllCourseView(),
      binding: ViewAllCourseBinding(),
    ),
    GetPage(
        name: _Paths.VIEW_COURSE_DETAIL,
        page: () => ViewCourseDetailView(),
        binding: ViewCourseDetailBinding()),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
