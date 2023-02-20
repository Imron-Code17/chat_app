import 'package:chat_app/app/controllers/auth_controller.dart';
import 'package:chat_app/app/themes/app_color.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading:
              IconButton(onPressed: () => Get.back(), icon: AppIconsB.back),
          title: Text('Update Status', style: AppTypoB.heading2),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: TextField(
                  controller: controller.statusC,
                  cursorColor: AppColor.primary,
                  decoration: InputDecoration(
                      hintText: 'Input status here...',
                      hintStyle: AppTypoH.highlight2,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 12.h),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.primary, width: 1.2),
                          borderRadius: BorderRadius.circular(28.r)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.primary, width: 1.2),
                          borderRadius: BorderRadius.circular(28.r)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.primary, width: 1.2),
                          borderRadius: BorderRadius.circular(28.r))),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                  height: 46,
                  width: Get.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r))),
                      onPressed: () {
                        authC.updateStatus(controller.statusC.text);
                      },
                      child: Text('Update Status', style: AppTypoW.heading2)))
            ],
          ),
        ));
  }
}
