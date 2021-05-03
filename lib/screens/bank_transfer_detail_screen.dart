import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/ManualInfo.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/screens/Order_Screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

class BankTransferDetailScreen extends StatefulWidget {
  static const String id = "bank_transfer_detail_screen";
  int order_id;
  BankTransferDetailScreen({Key key, this.order_id});

  @override
  _BankTransferDetailScreenState createState() =>
      _BankTransferDetailScreenState();
}

class _BankTransferDetailScreenState extends State<BankTransferDetailScreen> {
  final key = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreen(
          type: OrderScreen.unpaid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: key,
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    type: OrderScreen.unpaid,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xffF48262),
            ),
          ),
          title: Text(
            'Bank Transfer',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Yeseva',
              color: Hexcolor('#F48262'),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Stack(children: <Widget>[
          Scaffold(
            backgroundColor: Color(0xffFDF8F0),
            body: FutureBuilder<NewManualInfo>(
              future: Provider.of<OrderModel>(context).getManualpembayaran(
                  Provider.of<AppModel>(context).auth.access_token,
                  widget.order_id.toString()),
              builder: (BuildContext context,
                  AsyncSnapshot<NewManualInfo> snapshot) {
                print("snaaaap" + widget.order_id.toString());
                print(snapshot.data);
                if (snapshot.hasData) {
                  print("sukses dong");
                  return Container(
                    margin: MediaQuery.of(context).padding,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'SELESAIKAN PEMBAYARAN',
                              style: TextStyle(
                                fontFamily: 'Yeseva',
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffF48262),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          //                   <--- left side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'NOMOR PESANAN',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "#" + snapshot.data.code,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          'TOTAL PESANAN',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          nm_format.format(int.parse(
                                              snapshot.data.grandTotal)),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          //                   <--- left side
                                          color: Colors.white,
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'KODE UNIK',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          nm_format.format(int.parse(
                                              snapshot.data.uniqTfManual)),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'TRANSFER KE',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                              ),
                            ),
                          ),
                          Image.network(
                            snapshot.data.path,
                            height: 70,
                          ),
                          Text(
                            'a/n ' + snapshot.data.an,
                            style: TextStyle(
                              fontFamily: 'Brandon',
                            ),
                          ),
                          Text(
                            snapshot.data.norek,
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 20,
                              width: 70,
                              child: OutlineButton(
                                color: Color(0xffF48262),
                                child: Text(
                                  'Salin',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 12,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffF48262),
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                highlightedBorderColor: Color(0xffF48262),
                                onPressed: () {
                                  Clipboard.setData(new ClipboardData(
                                      text: snapshot.data.norek));
                                  key.currentState.showSnackBar(new SnackBar(
                                    content: new Text("Copied to Clipboard"),
                                  ));
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'JUMLAH YANG HARUS DIBAYAR',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data.ygHarusDibayar,
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                              height: 20,
                              width: 70,
                              child: OutlineButton(
                                color: Color(0xffF48262),
                                child: Text(
                                  'Salin',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 12,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xffF48262),
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                highlightedBorderColor: Color(0xffF48262),
                                onPressed: () {
                                  int total =
                                      int.parse(snapshot.data.grandTotal) +
                                          int.parse(snapshot.data.uniqTfManual);
                                  Clipboard.setData(new ClipboardData(
                                      text: total.toString()));
                                  key.currentState.showSnackBar(new SnackBar(
                                    content: new Text("Copied to Clipboard"),
                                  ));
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Pastikan kamu melakukan pembayaran dalam waktu 24 jam\nsetelah pesanan dibuat untuk menghindari pembatalan otomatis\ndan silahkan lakukan konfirmasi pembayaran jika kamu sudah\nmelakukan pembayaran di halaman my account.',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'KONFIRMASI PEMBAYARAN',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        KonfirmasiPembayaranScreen(
                                      manualInfo: snapshot.data,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  print("fail dong");
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: LoadingWidgetFadingCircle(context),
                    ),
                  );
                }
              },
            ),
          )
        ]),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
      ),
    );
  }
}
