
import 'package:dopamin/core/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

Future<String> scanCodes({required BuildContext context}) async {
  String value = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BarcodeScannerPage(),
    ),
  );
  if (value == '-1') {
    return '';
  } else {
    return value;
  }
}

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'qr');
  Barcode? result;
  bool canIPop = true;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مسح الرمز', style: kTextStyle.copyWith(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) =>
                  _onQRViewCreated(controller, context),
              overlay: QrScannerOverlayShape(),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, c) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (canIPop) {
          Navigator.pop(c, result!.code ?? '');
        }
        canIPop = false;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
