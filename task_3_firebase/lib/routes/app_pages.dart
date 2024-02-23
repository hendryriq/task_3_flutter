import 'package:get/get.dart';
import 'package:task_3_firebase/app/modules/home/bindings/home_bindings.dart';
import 'package:task_3_firebase/app/modules/home/views/home_view.dart';
import 'package:task_3_firebase/app/modules/introduction/bindings/introduction_binding.dart';
import 'package:task_3_firebase/app/modules/introduction/views/introduction_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    // GetPage(
    //   name: _Paths.LOGIN,
    //   page: () => LoginView(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROFILE,
    //   page: () => ProfileView(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CHAT_ROOM,
    //   page: () => ChatRoomView(),
    //   binding: ChatRoomBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SEARCH,
    //   page: () => SearchView(),
    //   binding: SearchBinding(),
    // ),
    // GetPage(
    //   name: _Paths.UPDATE_STATUS,
    //   page: () => UpdateStatusView(),
    //   binding: UpdateStatusBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CHANGE_PROFILE,
    //   page: () => ChangeProfileView(),
    //   binding: ChangeProfileBinding(),
    // ),
  ];
}