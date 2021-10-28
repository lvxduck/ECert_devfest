import 'package:dotted_line/dotted_line.dart';
import 'package:ecert/core/helper/extension.dart';
import 'package:ecert/features/home/model/certificate.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCertificate extends StatelessWidget {
  const ViewCertificate({Key? key, required this.certificate}) : super(key: key);

  final Certificate certificate;

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
                "Thông tin chi tiết",
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                "Bằng tốt nghiệp đại học",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...List.from(certificate.extraData.keys
                  .where(
                (element) => element != "time_add" && element != "type_cert",
              )
                  .map(
                (e) {
                  return CustomTextField(
                    label: e,
                    value: certificate.extraData[e],
                  );
                },
              )),
              Row(
                children: [
                  const Text("Đường dẫn:"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        final url = "https://n3iv.github.io/ECert/Search/?=${certificate.cid}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Stack(
                        children: [
                          Text(
                            "https://n3iv.github.io/ECert/Search/?=${certificate.cid.substring(0, 6)}...",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomTheme.lightColorScheme.primary,
                            ),
                          ),
                          Positioned(
                            bottom: 3,
                            left: 0,
                            child: Container(
                              height: 0.5,
                              width: 300,
                              color: CustomTheme.lightColorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    // child: Linkify(
                    //   onOpen: (link) async {
                    //     if (await canLaunch(link.url)) {
                    //       await launch(link.url);
                    //     } else {
                    //       throw 'Could not launch $link';
                    //     }
                    //   },
                    //   text: "https://n3iv.github.io/ECert/Search/?=${certificate.cid}",
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(fontSize: 12),
                    // ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: "https://n3iv.github.io/ECert/Search/?=${certificate.cid}"),
                      );
                    },
                    icon: Icon(
                      Icons.file_copy,
                      color: CustomTheme.lightColorScheme.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        const Divider(height: 1),
        const SizedBox(height: 14),
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

  void genData() {}
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.label, required this.value}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${label.toCapitalized()}:",
        ),
        Expanded(
          child: SizedBox(
            height: 34,
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  left: 16,
                  child: SelectableText(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
          ),
        )
      ],
    );
  }
}
