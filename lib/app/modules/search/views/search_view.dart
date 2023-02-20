import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/app_color.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final List<Widget> friends = List.generate(
      20,
      (index) => ListTile(
            leading: CircleAvatar(
              radius: 35,
              child: Image.asset(
                "assets/logo/noimage.png",
                width: 64.0,
                height: 64.0,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              "Nama ke ${index + 1}",
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            subtitle: Text(
              "Status ke ${index + 1}",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => Get.toNamed(Routes.CHAT_ROOM),
              child: Chip(
                label: Text(
                  "Messege",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: AppColor.primary,
              title: Text('Search', style: AppTypoW.heading1),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              flexibleSpace: Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 56,
                      child: TextField(
                        cursorColor: AppColor.primary,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search new friend hire...',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 20),
                            suffixIcon: InkWell(
                                onTap: () {}, child: Icon(Icons.search)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    )),
              ),
            ),
            preferredSize: Size.fromHeight(135)),
        body: friends.length == 0
            ? Center(
                child: Container(
                width: Get.width * 0.7,
                height: Get.width * 0.7,
                child: Lottie.asset('assets/lottie/empty.json'),
              ))
            : ListView.builder(
                itemCount: friends.length,
                itemBuilder: (_, index) => friends[index]));
  }
}
