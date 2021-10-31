import 'package:ecert/core/widget/card_setup_wrapper.dart';
import 'package:ecert/features/login/controller/login_controller.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

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
                "Đăng nhập",
                style: Get.theme.textTheme.headline3,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _controller.privateKeyController,
                decoration: const InputDecoration(
                  hintText: "Nhập khóa bí mật của bạn",
                ),
                validator: _controller.privateKeyValidator,
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _controller.submit(_formKey);
                  },
                  child: const Text("Đăng nhập"),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản? ",
                    style: Get.textTheme.bodyText2,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: _controller.moveToSignUp,
                    child: Text(
                      "Đăng ký",
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
