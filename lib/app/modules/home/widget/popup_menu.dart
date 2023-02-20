import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget popupMenu() {
  return PopupMenuButton<String>(
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'Profile',
        child: Text(
          'Profile',
          style: AppTypoB.highlight2,
        ),
      ),
      PopupMenuItem<String>(
        value: 'Status',
        child: Text(
          'Status',
          style: AppTypoB.highlight2,
        ),
      ),
      PopupMenuItem<String>(
        value: 'Setting',
        child: Text(
          'Setting',
          style: AppTypoB.highlight2,
        ),
      ),
    ],
    onSelected: (String value) {
      switch (value) {
        case 'Profile':
          Get.toNamed(Routes.PROFILE);
          break;
        case 'Status':
          Get.toNamed(Routes.UPDATE_STATUS);
          break;
        case 'Setting':
          break;
      }
    },
    child: Icon(Icons.more_vert_rounded, color: Colors.white),
  );
}
