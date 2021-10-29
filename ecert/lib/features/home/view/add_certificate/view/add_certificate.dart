import 'package:dotted_line/dotted_line.dart';
import 'package:ecert/core/helper/extension.dart';
import 'package:ecert/features/home/view/add_certificate/controller/add_certificate_controller.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCertificate extends StatefulWidget {
  const AddCertificate({Key? key}) : super(key: key);

  @override
  _AddCertificateState createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  String dropdownValue = 'Bằng tốt nghiệp đại học';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddCertificateController _controller = Get.put(AddCertificateController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 32),
              Text(
                "Thêm văn bằng",
                style: Get.textTheme.headline4,
              ),
              IconButton(
                onPressed: Get.back,
                icon: Icon(
                  Icons.clear,
                  color: CustomTheme.lightColorScheme.primary,
                ),
              )
            ],
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                SizedBox(
                  width: 260,
                  height: 32,
                  child: DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    items: <String>[
                      'Bằng tốt nghiệp đại học',
                      'Chứng chỉ tin học',
                      'Chứng chỉ ngoại ngữ',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: CustomTheme.lightColorScheme.primary),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                ...List.from(_controller.format.map(
                  (e) {
                    final textController = TextEditingController();
                    _controller.textEditingControllers.add(textController);
                    return CustomTextField(
                      label: e,
                      textController: textController,
                    );
                  },
                )),
              ],
            ),
          ),
        ),
        const Spacer(),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.submit(_formKey);
              },
              child: const Text("Thêm mới"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: Get.back,
              child: Text(
                "Hủy",
                style: TextStyle(color: CustomTheme.lightColorScheme.primary),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, required this.label, required this.textController}) : super(key: key);
  final AddCertificateController _controller = Get.put(AddCertificateController());
  final TextEditingController textController;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label.toCapitalized(),
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: 34,
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "Nhập $label",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    errorStyle: const TextStyle(height: 0, color: Colors.white),
                  ),
                  validator: _controller.inputValidator,
                ),
              ),
              const Positioned(
                bottom: 6,
                left: 16,
                child: SizedBox(
                  width: 800,
                  child: DottedLine(
                    dashLength: 3,
                    lineThickness: 0.5,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
