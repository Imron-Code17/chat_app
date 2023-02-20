import 'package:chat_app/app/themes/app_typo.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/auth_controller.dart';
import '../../../themes/app_color.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  final authC = Get.find<AuthController>();
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
                      height: 48,
                      child: TextField(
                        cursorColor: AppColor.primary,
                        controller: controller.searchC,
                        onChanged: (value) => controller.searchFriend(
                            value, authC.user.value.email!),
                        style: AppTypoB.highlight2,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search new friend here...',
                            hintStyle: AppTypoH.highlight2,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 14),
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
        body: Obx(() => controller.tempSearch.length == 0
            ? Center(
                child: Container(
                width: Get.width * 0.7,
                height: Get.width * 0.7,
                child: Lottie.asset('assets/lottie/empty.json'),
              ))
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.tempSearch.length,
                itemBuilder: (_, index) => ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      // onTap: () => Get.toNamed(Routes.CHAT_ROOM),
                      leading: CircleAvatar(
                        radius: 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: controller.tempSearch[index]["photoUrl"] ==
                                  "noimage"
                              ? Image.asset(
                                  "assets/logo/noimage.png",
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  controller.tempSearch[index]["photoUrl"],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      title: Text(
                        "${controller.tempSearch[index]['name']}",
                        style: AppTypoB.highlight2,
                      ),
                      subtitle: Text(
                        "${controller.tempSearch[index]['email']}",
                        style: AppTypoH.highlight3,
                      ),
                      trailing: GestureDetector(
                        onTap: () => authC.addNewConnection(
                          controller.tempSearch[index]["email"],
                        ),
                        child: Chip(
                          backgroundColor: AppColor.active,
                          label: Text(
                            "Messege",
                            style: AppTypoW.content,
                          ),
                        ),
                      ),
                    ))));
  }
}
