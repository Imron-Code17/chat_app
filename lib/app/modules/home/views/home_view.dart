import 'package:chat_app/app/modules/home/widget/popup_menu.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../themes/app_color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
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
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(listDocsChats[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            return data!["status"] == ""
                                ? ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 5.h,
                                    ),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      authC.user.value.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text("${data["name"]}",
                                        style: AppTypoB.highlight2),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Container(
                                            height: 20.h,
                                            width: 20.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.utils),
                                            child: Center(
                                              child: Text(
                                                  "${listDocsChats[index]["total_unread"]}",
                                                  style: AppTypoW.content),
                                            ),
                                          ),
                                  )
                                : ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    onTap: () => controller.goToChatRoom(
                                          "${listDocsChats[index].id}",
                                          authC.user.value.email!,
                                          listDocsChats[index]["connection"],
                                        ),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black26,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: data["photoUrl"] == "noimage"
                                            ? Image.asset(
                                                "assets/logo/noimage.png",
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                "${data["photoUrl"]}",
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    title: Text("${data["name"]}",
                                        style: AppTypoB.highlight2),
                                    subtitle: Text("${data["status"]}",
                                        style: AppTypoH.highlight3),
                                    trailing: listDocsChats[index]
                                                ["total_unread"] ==
                                            0
                                        ? SizedBox()
                                        : Container(
                                            height: 20.h,
                                            width: 20.w,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.utils),
                                            child: Center(
                                              child: Text(
                                                  "${listDocsChats[index]["total_unread"]}",
                                                  style: AppTypoW.content),
                                            ),
                                          ));
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
