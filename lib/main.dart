import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/utils/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          // return Obx(() => GetMaterialApp(
          //       debugShowCheckedModeBanner: false,
          //       title: 'Chat App',
          //       initialRoute:
          //           authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
          //       getPages: AppPages.routes,
          //     ));
          return FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return Obx(() => GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Chat App',
                        initialRoute: authC.isSkipIntro.isTrue
                            ? authC.isAuth.isTrue
                                ? Routes.HOME
                                : Routes.LOGIN
                            : Routes.INTRODUCTION,
                        getPages: AppPages.routes,
                      ));
                } else {
                  return FutureBuilder(
                      future: authC.firstInitialize(),
                      builder: (context, snap) {
                        return SplashScreen();
                      });
                }
              });
        });
  }
}
