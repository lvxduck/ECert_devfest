import 'package:ecert/core/helper/extension.dart';
import 'package:ecert/core/helper/ipfs_utils.dart';
import 'package:ecert/core/widget/custom_dialog.dart';
import 'package:ecert/features/login/view/login.dart';
import 'package:ecert/features/sign_up_warning/view/sign_up_warning.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxString avatarUrl = "".obs;

  void submit(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      CustomDialog.showLoading();
      await Future.delayed(1.seconds);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("name", schoolNameController.text);
      Get.back();
      Get.to(SignUpWarning());
    }
  }

  void upLoadImage() async {
    final filePicker = OpenFilePicker()
      ..filterSpecification = {
        'Ảnh': '*.jpg;*.jpeg;*.png',
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'png'
      ..title = 'Chọn một hình ảnh';
    final file = filePicker.getFile();
    if (file != null) {
      CustomDialog.showLoading();
      final response = await IpfsUtils().uploadImage(file);
      Get.back();
      if (response != null) {
        avatarUrl.value = response.cid.ipfs;
      }
    }
  }

  void moveToLogin() async {
    Get.to(() => Login());
  }

  String? schoolNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bạn chưa nhập tên trường';
    }
    return null;
  }

  String? emailNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bạn chưa nhập email';
    }
    if (!value.isEmail) {
      return 'Bạn nhập email sai định dạng';
    }
    return null;
  }
}
