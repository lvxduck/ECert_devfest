import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCertificateFromExcel extends StatefulWidget {
  const AddCertificateFromExcel({Key? key, required this.onUpload}) : super(key: key);
  final VoidCallback onUpload;

  @override
  _AddCertificateFromExcelState createState() => _AddCertificateFromExcelState();
}

class _AddCertificateFromExcelState extends State<AddCertificateFromExcel> {
  String dropdownValue = 'Bằng tốt nghiệp đại học';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 32),
              Text(
                "Thêm từ Excel",
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
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: CustomTheme.lightColorScheme.primary),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: widget.onUpload,
                  icon: Icon(
                    Icons.cloud_upload,
                    color: CustomTheme.lightColorScheme.primary,
                  ),
                  label: const Text(
                    "Tải lên",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    const Text("Tải mẫu bằng tốt nghiệp đại học "),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "tại đây",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomTheme.lightColorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: Get.back, child: const Text("Đóng")),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
