import 'dart:convert';

import 'package:ecert/ipfs/ipfs_utils.dart';
import 'package:ecert/core/widget/custom_dialog.dart';
import 'package:ecert/features/home/model/certificate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCertificateController extends GetxController {
  List<String> format = [
    "tên trường",
    "loại bằng",
    "ngành học",
    "họ tên",
    "ngày sinh",
    "năm tốt nghiệp",
    "xếp loại tốt nghiệp",
    "hình thức đào tạo",
    "thời gian",
    "số hiệu",
    "số vào sổ cấp bằng",
  ];

  List<TextEditingController> textEditingControllers = [];

  void submit(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      CustomDialog.showLoading();
      Map<String, dynamic> data = {};
      for (int i = 0; i < format.length; i++) {
        data[format[i]] = textEditingControllers[i].text;
      }
      data["time_add"] = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      data["type_cert"] = "Bằng tốt nghiệp đại học";
      final res = await IpfsUtils().uploadJsonData(content: jsonEncode(data));
      print(res?.cid);
      Get.back();
      Get.back(result: res?.cid);
    } else {
      CustomDialog.showAlertDialog("Thông báo", "Bạn chưa nhập đủ thông tin.");
    }
  }

  String? inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bạn chưa nhập';
    }
    return null;
  }
}
