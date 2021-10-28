import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

final icon = """<svg width="150" height="150" viewBox="0 0 150 150" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="3" y="3" width="144" height="144" rx="72" stroke="#F15E5E" stroke-width="6"/>
<path d="M102.117 49.3441L96.5739 43.2795L74.5971 67.3226L52.6203 43.2795L47.0769 49.3441L69.0537 73.3871L47.0769 97.4301L52.6203 103.495L74.5971 79.4516L96.5739 103.495L102.117 97.4301L80.1404 73.3871L102.117 49.3441Z" fill="#F15E5E"/>
</svg>
""";

class DeleteCertificate extends StatelessWidget {
  const DeleteCertificate({Key? key, required this.onDelete}) : super(key: key);
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: SvgPicture.string(icon),
          ),
          const SizedBox(height: 8),
          const Text(
            "Bạn chắc chứ?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Expanded(
            child: Align(
              child: Text("Bạn có thật sự muốn xóa giấy chứng nhận này không? Quá trình này không thể hoàn tác."),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: Get.back,
                child: const Text("Quay lại"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onDelete,
                child: Text(
                  "Xóa",
                  style: TextStyle(color: CustomTheme.lightColorScheme.primary),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
