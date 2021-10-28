import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1800), () {
      // Get.offAll(() => Setup());
    });
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(120.0),
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          Text("Powerd by xduck", style: Get.textTheme.bodyText1),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
