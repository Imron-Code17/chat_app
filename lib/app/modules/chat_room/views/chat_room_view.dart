import 'package:chat_app/app/themes/app_color.dart';
import 'package:chat_app/app/themes/app_icon.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/chat_room_controller.dart';
import '../widget/emoji_keyboard.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.primary,
          leadingWidth: 88.w,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: () => Get.back(), icon: AppIconsW.back),
              CircleAvatar(
                backgroundColor: AppColor.primary,
                backgroundImage: AssetImage('assets/logo/noimage.png'),
              )
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama',
                style: AppTypoW.highlight2,
              ),
              SizedBox(height: 4.h),
              Text(
                'Terakhir dilihat 20.00',
                style: AppTypoW.highlight3,
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            if (controller.isShowEmoji.isTrue) {
              controller.isShowEmoji.value = false;
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.grey.shade200,
                child: ListView(
                  children: [
                    ItemChat(
                      isSender: true,
                    ),
                    ItemChat(
                      isSender: false,
                    ),
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 48,
                        child: TextField(
                          controller: controller.chatC,
                          focusNode: controller.focusNode,
                          cursorColor: AppColor.accent,
                          style: AppTypoW.highlight3,
                          decoration: InputDecoration(
                              hintText: 'Send massage...',
                              hintStyle: AppTypoW.highlight3,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 6.h),
                              fillColor: AppColor.primary,
                              filled: true,
                              prefixIcon: IconButton(
                                  onPressed: () {
                                    controller.focusNode.unfocus();
                                    controller.isShowEmoji.toggle();
                                  },
                                  icon: AppIconsW.emoji),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 26.r,
                        backgroundColor: AppColor.utils,
                        child: AppIconsW.send,
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => (controller.isShowEmoji.isTrue)
                  ? Container(
                      height: 325.h,
                      child: emojiKey(),
                    )
                  : SizedBox())
            ],
          ),
        ));
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({super.key, required this.isSender});

  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: isSender
                    ? BorderRadius.only(
                        topLeft: Radius.circular(14.r),
                        topRight: Radius.circular(14.r),
                        bottomLeft: Radius.circular(14.r))
                    : BorderRadius.only(
                        topLeft: Radius.circular(14.r),
                        topRight: Radius.circular(14.r),
                        bottomRight: Radius.circular(14.r))),
            child: Text(
              'Ahsjdakajaaaaaaaaaaaaaaaaaaa',
              style: AppTypoW.highlight3,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '19.02 PM',
            style: AppTypoB.jam,
          )
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
