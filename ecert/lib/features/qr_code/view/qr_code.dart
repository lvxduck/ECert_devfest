import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double scanArea = (screenSize.width < 400 || screenSize.height < 400) ? 250.0 : 300.0;
    const double cutOutBottomOffset = 60;

    Widget _buildQrView() {
      return QRView(
        key: qrKey,
        cameraFacing: CameraFacing.back,
        onQRViewCreated: _onQRViewCreated,
        formatsAllowed: const <BarcodeFormat>[BarcodeFormat.qrcode],
        overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 0,
          borderLength: 18,
          borderWidth: 6,
          cutOutBottomOffset: cutOutBottomOffset,
          cutOutSize: scanArea,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quét mã QR',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          _buildQrView(),
          Container(
            alignment: AlignmentDirectional.center,
            margin: const EdgeInsets.only(bottom: cutOutBottomOffset * 2),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[Container(height: 2, color: Colors.red), Container(width: 2, color: Colors.red)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenSize.height / 2 + scanArea / 2 - cutOutBottomOffset),
            alignment: AlignmentDirectional.topCenter,
            child: Text(
              'Di chuyển camera đến vùng chứa mã QR để quét',
              style: TextStyle(color: Colors.grey[300], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((Barcode scanData) {
      controller.dispose();
      Get.back(result: scanData.code);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
