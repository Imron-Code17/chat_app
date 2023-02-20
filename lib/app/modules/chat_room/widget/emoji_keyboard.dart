import 'package:chat_app/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:chat_app/app/themes/app_color.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget emojiKey() {
  final controller = Get.put(ChatRoomController());
  return EmojiPicker(
    onEmojiSelected: (category, emoji) {
      controller.addEmojiToChat(emoji);
    },
    onBackspacePressed: () {
      controller.deleteEmoji();
    },
    textEditingController:
        null, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
    config: Config(
      columns: 7,
      verticalSpacing: 0,
      horizontalSpacing: 0,
      gridPadding: EdgeInsets.zero,
      initCategory: Category.RECENT,
      bgColor: Colors.white,
      indicatorColor: AppColor.primary,
      iconColor: Colors.grey,
      iconColorSelected: AppColor.primary,
      backspaceColor: AppColor.primary,
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      enableSkinTones: true,
      showRecentsTab: true,
      recentsLimit: 28,
      noRecents: const Text(
        'No Recents',
        style: TextStyle(fontSize: 20, color: Colors.black26),
        textAlign: TextAlign.center,
      ), // Needs to be const Widget
      loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
    ),
  );
}
