import 'package:ecert/core/widget/avatar.dart';
import 'package:ecert/features/home/controller/home_controller.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSize appBar() {
  final HomeController controller = Get.find();
  return PreferredSize(
    preferredSize: const Size.fromHeight(52),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/logo.png",
              ),
              const SizedBox(width: 8),
              Text(
                "ECert",
                style: Get.textTheme.headline6,
              ),
            ],
          ),
          Obx(() {
            return Text(
              controller.schoolName.value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          }),
          PopupMenuButton<String>(
            onSelected: (s) {
              switch (s) {
                case 'Đăng xuất':
                  controller.logout();
                  break;
                case 'Chi tiết':
                  {
                    // controller.deleteRoom();
                  }
                  break;
                default:
                  {
                    print("ERROR");
                  }
              }
            },
            iconSize: 36,
            padding: const EdgeInsets.all(0),
            icon: const Avatar(
              size: 36,
              url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Logodhbk.jpg',
            ),
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return {'Đăng xuất', 'Chi tiết'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    ),
  );
}
