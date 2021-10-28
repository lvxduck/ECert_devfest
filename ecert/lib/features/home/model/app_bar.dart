import 'package:ecert/core/widget/avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSize appBar() {
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
          const Text(
            "Trường Đại học Bách khoa - Đại học Đà Nẵng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Avatar(
            size: 36,
            url: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Logodhbk.jpg',
          ),
        ],
      ),
    ),
  );
}
