import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_3_firebase/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_3_firebase/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              title: 'Application',
              // initialRoute: Route.HOME,
              // getPages: AppPages.routes,
            );
          }
          return LoadingView();
        });
  }
}
