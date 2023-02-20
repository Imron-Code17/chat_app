import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/themes/app_color.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Container(
                width: Get.width * 0.7,
                height: Get.height * 0.7,
                child: Lottie.asset('assets/lottie/login.json'),
              ),
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  height: 58,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r))),
                      onPressed: () => authC.login(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            child: Image.asset('assets/logo/google.png'),
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            'Sign in with Google',
                            style: AppTypoW.highlight2,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
