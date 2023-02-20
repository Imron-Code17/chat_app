import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/themes/app_color.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading:
              IconButton(onPressed: () => Get.back(), icon: AppIconsB.back),
          actions: [
            IconButton(onPressed: () => authC.logout(), icon: AppIconsB.logout)
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 26.h),
                  AvatarGlow(
                    endRadius: 110,
                    glowColor: AppColor.utils,
                    duration: Duration(seconds: 2),
                    child: Container(
                        margin: EdgeInsets.all(16),
                        height: 175.h,
                        width: 175.w,
                        child: ClipRRect(
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
                        )),
                  ),
                  SizedBox(height: 22.h),
                  Obx(
                    () => Text(
                      '${authC.user.value.name}',
                      style: AppTypoB.heading1,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${authC.user.value.email}',
                    style: AppTypoB.highlight3,
                  )
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Container(
              child: Column(
                children: [
                  ListTile(
                    leading: AppIconsB.status,
                    title: Text('Update Status', style: AppTypoB.highlight2),
                    trailing: AppIconsB.next,
                  ),
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: AppIconsB.profile,
                    title: Text('Change Profile', style: AppTypoB.highlight2),
                    trailing: AppIconsB.next,
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  Text(
                    'Chat App',
                    style: AppTypoB.highlight2,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Versi 1.0',
                    style: AppTypoB.highlight3,
                  )
                ],
              ),
            ),
            SizedBox(height: 55.h)
          ],
        ));
  }
}
