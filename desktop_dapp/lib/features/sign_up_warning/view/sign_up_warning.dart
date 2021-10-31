import 'package:ecert/core/widget/card_setup_wrapper.dart';
import 'package:ecert/core/widget/custom_tooltip.dart';
import 'package:ecert/features/sign_up_warning/controller/sign_up_warning_controller.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpWarning extends StatelessWidget {
  SignUpWarning({Key? key}) : super(key: key);
  final SignUpWarningController _controller = Get.put(SignUpWarningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardSetupWrapper(
        child: Column(
          children: [
            const SizedBox(height: 36),
            Text(
              "Đăng ký thành công",
              style: Get.theme.textTheme.headline3,
            ),
            const SizedBox(height: 42),
            const Text("Đây là khóa bí mật của bạn, hãy lưu nó cho những lần đăng nhập tiếp theo."),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Khóa bí mật (click để sao chép)",
                style: Get.textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: 8),
            TooltipTap(
              hoveMessage: 'Click để sao chép',
              clickMessage: "Đã sao chép",
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: _controller.privateKey),
                );
              },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: CustomTheme.lightColorScheme.primary, width: 2),
                    ),
                    child: Text(
                      _controller.privateKey,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Icon(
                      Icons.file_copy,
                      color: CustomTheme.lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(
                text: "Cảnh báo: ",
                style: TextStyle(fontSize: 14, color: CustomTheme.lightColorScheme.error, fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(
                    text: "Không được tiết lộ khóa bí mật. Bất kì ai có khóa bí mật của bạn "
                        "đều có thể ăn cắp mọi dữ liệu được lưu giữ ở trong tài khoản của bạn.",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.moveToHome,
                child: const Text("Tiếp tục"),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bằng cách tiếp tục, bạn đồng ý với các ",
                  style: TextStyle(fontSize: 11),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    print("tap tap 2");
                  },
                  child: Text(
                    "Điều khoản và Điều kiện",
                    style: TextStyle(
                      fontSize: 11,
                      color: CustomTheme.lightColorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
