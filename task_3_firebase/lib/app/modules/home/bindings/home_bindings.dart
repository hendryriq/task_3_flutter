import 'package:get/get.dart';
import 'package:task_3_firebase/app/modules/home/controller/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }
}