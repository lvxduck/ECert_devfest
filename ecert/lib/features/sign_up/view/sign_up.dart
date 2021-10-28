import 'package:ecert/core/widget/avatar.dart';
import 'package:ecert/core/widget/card_setup_wrapper.dart';
import 'package:ecert/features/sign_up/controller/signup_controller.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final SignUpController _controller = Get.put(SignUpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardSetupWrapper(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 36),
              Text(
                "Đăng kí",
                style: Get.theme.textTheme.headline3,
              ),
              Expanded(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: _controller.upLoadImage,
                  child: Obx(
                    () => Avatar(
                      url: _controller.avatarUrl.value,
                      size: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controller.schoolNameController,
                decoration: const InputDecoration(
                  hintText: "Nhập tên trường",
                ),
                validator: _controller.schoolNameValidator,
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _controller.submit(_formKey);
                  },
                  child: const Text("Đăng kí"),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản? ",
                    style: Get.textTheme.bodyText2,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: _controller.moveToLogin,
                    child: Text(
                      "Đăng nhập",
                      style: Get.textTheme.bodyText2?.copyWith(
                        color: CustomTheme.lightColorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
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
      ),
    );
  }
}
