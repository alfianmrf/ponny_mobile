import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
//import 'dart:wasm';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                NotificationListener<SizeChangedLayoutNotification>(
                  child: SizeChangedLayoutNotifier(
                    key: const Key('qr-size-notifier'),
                    child: QRView(
                      key: qrKey,
                      overlay: QrScannerOverlayShape(
                          borderRadius: 8,
                          borderColor: Color(0xffF48262),
                          borderWidth: 13,
                          borderLength: 16),
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: size.width,
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,
                                color: Color(0xffF48262), size: 26)),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Text(
                            'Scan QR',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          Text(
                            'Pindai kode QR produk yang tersedia dengan kamera',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Brandon",
                                color: Colors.white),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        FlutterIcons.flash_on_mdi,
                        color: Colors.white,
                        size: 35,
                      )),
                )
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Center(
          //     child: (result != null)
          //         ? Text(
          //             'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
          //         : Text('Scan a code'),
          //   ),
          // )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
