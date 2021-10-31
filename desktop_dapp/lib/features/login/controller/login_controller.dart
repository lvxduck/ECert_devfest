import 'package:ecert/core/widget/custom_dialog.dart';
import 'package:ecert/features/home/view/home.dart';
import 'package:ecert/features/sign_up/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController privateKeyController = TextEditingController();

  @override
  void dispose() {
    privateKeyController.dispose();
    super.dispose();
  }

  void submit(GlobalKey<FormState> formKey) async {
    // EcertSmartContract();
    if (formKey.currentState!.validate()) {
      CustomDialog.showLoading();
      await Future.delayed(1.seconds);
      Get.back();
      Get.to(Home());
    }
  }

  void moveToSignUp() {
    Get.to(() => SignUp());
  }

  String? privateKeyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bạn chưa nhập privateKey';
    }
    if (!value.isSHA256) {
      return 'Bạn nhập sai định dạng';
    }
    return null;
  }
}
