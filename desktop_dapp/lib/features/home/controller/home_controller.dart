import 'dart:convert';

import 'package:ecert/ipfs/ipfs_utils.dart';
import 'package:ecert/core/widget/custom_dialog.dart';
import 'package:ecert/features/home/model/certificate.dart';
import 'package:ecert/features/home/view/add_certificate/view/add_certificate.dart';
import 'package:ecert/features/home/view/add_certificate_from_excel.dart';
import 'package:ecert/features/home/view/delete_certificate.dart';
import 'package:ecert/features/home/view/view_certificate.dart';
import 'package:ecert/features/home/widget/certificate_data_source.dart';
import 'package:ecert/features/login/view/login.dart';
import 'package:excel/excel.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  List<String> cids = [
    "QmXxnGaac9GkVBD1v2Ahvr2gGQGxfcS4GheiHVeuFphoQF",
    "QmWzHpM4ewcrgmkzx5ebXhLjs5CpB3Pkywp4mf2ExGLjGg",
    "QmSHNVuo9Q6d3vH1M7bRDnPcecTodMDjze35H3eoWJRmrN",
    "QmNhfd5BW5FC9hAfSGF6XqqZVBvrbAzvuEqba4HGxajhDq",
  ];

  late List<Certificate?> dataCert;
  late Rx<CertificateDataSource> orderInfoDataSource;
  final TextEditingController searchController = TextEditingController();
  final RxString schoolName = "".obs;

  @override
  void onInit() {
    dataCert = RxList.generate(cids.length, (index) => null);
    orderInfoDataSource = CertificateDataSource(employeeData: dataCert).obs;
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    schoolName.value = prefs.getString("name") ?? "";
    for (int i = 0; i < cids.length; i++) {
      initCer(cids[i], i);
    }
  }

  void initCer(String cid, int index) async {
    try {
      final rawCert = await IpfsUtils().getData(cid);
      dataCert[index] = Certificate.fromJson(json: jsonDecode(rawCert), cid: cid);
      orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
    } catch (e) {
      CustomDialog.showAlertDialog("L???i", e.toString());
    }
  }

  void onSearchSubmitted(String value) {
    List<Certificate?> certs = [];
    certs.addAll(dataCert);
    certs.removeWhere((e) => e == null || !e.name.toLowerCase().contains(value.toLowerCase()));
    orderInfoDataSource.value = CertificateDataSource(employeeData: certs);
  }

  void onClearSearch() {
    searchController.text = "";
    orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
  }

  void addCertificate() async {
    var cid = await CustomDialog.showModal(
      width: 500,
      height: 600,
      child: const AddCertificate(),
    );
    if (cid != null) {
      cids.add(cid);
      dataCert.insert(0, null);
      orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
      final rawCert = await IpfsUtils().getData(cid);
      dataCert[0] = Certificate.fromJson(json: jsonDecode(rawCert), cid: cid);
      orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
    }
  }

  void alertDeleteCertificate(int index) async {
    CustomDialog.showModal(
      width: 400,
      height: 300,
      child: DeleteCertificate(
        onDelete: () {
          Get.back();
          dataCert.removeAt(index - 1);
          orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
        },
      ),
    );
  }

  void addFromExcel() async {
    CustomDialog.showModal(
      width: 400,
      height: 300,
      child: AddCertificateFromExcel(
        onUpload: () {
          final filePicker = OpenFilePicker()
            ..filterSpecification = {
              'Excel': '*.xlsx',
            }
            ..defaultFilterIndex = 0
            ..defaultExtension = 'xlsx'
            ..title = 'Ch???n m???t file Excel';
          final file = filePicker.getFile();
          if (file != null) {
            var bytes = file.readAsBytesSync();
            var excel = Excel.decodeBytes(bytes);

            for (var table in excel.tables.keys) {
              List<List<Data?>> rows = excel.tables[table]!.rows;
              for (int i = 1; i < rows.length; i++) {
                Map<String, dynamic> data = {};
                for (int j = 0; j < rows[i].length - 1; j++) {
                  print(rows[i][j]?.props.first);
                  data[rows[0][j]?.props.first.toString() ?? "blank"] = rows[i][j]?.props.first.toString();
                }
                data["time_add"] = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
                data["type_cert"] = "B???ng t???t nghi???p ?????i h???c";
                dataCert.insert(0, null);
                IpfsUtils().uploadJsonData(content: jsonEncode(data)).then((res) async {
                  print(res?.cid);
                  String? cid = res?.cid;
                  if (cid != null) {
                    final rawCert = await IpfsUtils().getData(cid);
                    int index = dataCert.indexWhere((element) => element == null);
                    dataCert[index] = Certificate.fromJson(json: jsonDecode(rawCert), cid: cid);
                    orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
                  }
                });
              }
              orderInfoDataSource.value = CertificateDataSource(employeeData: dataCert);
            }
          }
        },
      ),
    );
  }

  void logout() {
    CustomDialog.showConfirmDialog(
      title: "????ng xu???t",
      content: "B???n c?? ch???c l?? mu???n ????ng xu???t?",
      onConfirm: () {
        Get.offAll(() => Login());
      },
    );
  }

  void handleRowPressed(int index) {
    Certificate? certificate = dataCert[index - 1];
    if (certificate != null) {
      CustomDialog.showModal(
        width: 500,
        height: 600,
        child: ViewCertificate(certificate: certificate),
      );
    }
  }
}
