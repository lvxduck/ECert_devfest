import 'package:ecert/core/widget/custom_dialog.dart';
import 'package:ecert/features/home/view/home.dart';
import 'package:ecert/features/login/view/login.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpWarningController extends GetxController {
  String privateKey = "f82caf65b481bce79a68fe76b88a0ee032205caf1bae23f1e51eb8395cadd86d";

  void moveToHome() async {
    final clipboardData = await Clipboard.getData("text/plain");
    if (clipboardData?.text != privateKey) {
      CustomDialog.showWarning("Bạn chưa lưu khóa bí mật!");
    } else {
      CustomDialog.showAlertDialog(
        "Thông báo",
        "Tài khoản của bạn đã được tạo và đang\nđược xác minh. Chúng tôi sẽ phản hồi   \ncho bạn trong vòng 3 ngày tới.",
        onClose: () {
          Get.offAll(() => Login());
        },
      );
    }
  }
}
