import 'package:chat_app/app/modules/home/widget/popup_menu.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final List<Widget> myChat = List.generate(
      20,
      (index) => ListTile(
            onTap: () => Get.toNamed(Routes.CHAT_ROOM),
            leading: CircleAvatar(
              radius: 24,
              child: Image.asset(
                "assets/logo/noimage.png",
                width: 48,
                height: 48,
              ),
            ),
            title: Text(
              "Nama ke ${index + 1}",
              style: AppTypoB.highlight2,
            ),
            subtitle: Text(
              "Status ke ${index + 1}",
              style: AppTypoH.highlight3,
            ),
            trailing: Chip(
              backgroundColor: AppColor.active,
              label: Text(
                "3",
                style: AppTypoW.content,
              ),
            ),
          )).reversed.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () => Get.toNamed(Routes.SEARCH),
        child: AppIconsW.search,
      ),
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Chat",
          style: AppTypoW.heading1,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: popupMenu(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: myChat.length,
                  itemBuilder: (_, index) => myChat[index]))
        ],
      ),
    );
  }
}
