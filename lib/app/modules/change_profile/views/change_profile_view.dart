import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/themes/app_color.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../themes/app_typo.dart';
import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading:
              IconButton(onPressed: () => Get.back(), icon: AppIconsB.back),
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                AvatarGlow(
                  endRadius: 75,
                  glowColor: AppColor.utils,
                  duration: Duration(seconds: 3),
                  child: Container(
                      margin: EdgeInsets.all(14),
                      height: 120,
                      width: 120,
                      child: Obx(() => ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: authC.user.value.photoUrl == "noimage"
                                ? Image.asset(
                                    'assets/logo/noimage.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "${authC.user.value.photoUrl}",
                                    fit: BoxFit.cover,
                                  ),
                          ))),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                    height: 56,
                    child: TextField(
                      controller: controller.nameC,
                      decoration: InputDecoration(
                          labelText: 'Nama',
                          labelStyle: AppTypoB.highlight3,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary))),
                    )),
                SizedBox(height: 12.h),
                SizedBox(
                    height: 56,
                    child: TextField(
                      controller: controller.emailC,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppTypoB.highlight3,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary))),
                    )),
                SizedBox(height: 12.h),
                SizedBox(
                    height: 56,
                    child: TextField(
                      controller: controller.statusC,
                      decoration: InputDecoration(
                          labelText: 'Status',
                          labelStyle: AppTypoB.highlight3,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.r),
                              borderSide: BorderSide(color: AppColor.primary))),
                    )),
                SizedBox(height: 32.h),
                SizedBox(
                  height: 58,
                  child: ElevatedButton(
                      onPressed: () => authC.changeProfile(
                          controller.nameC.text, controller.statusC.text),
                      child: Text(
                        'Update',
                        style: AppTypoW.highlight2,
                      )),
                )
              ],
            )));
  }
}
