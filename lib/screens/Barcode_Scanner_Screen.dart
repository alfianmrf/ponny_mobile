part of 'pages.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  Future<void>getQR() async{
      controller.stopCamera();
      Provider.of<ProductModel>(context).getQRCode(Provider.of<AppModel>(context).auth.access_token, result.code).then((value){
          print("ini hasilnya--------");
          print(value);
          if (value != null)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  ProductDetailsScreen(product: value,isScan: true,)),
            );
      });
  }

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
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Color(0xffF48262), size: 26)),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
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
        getQR();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
