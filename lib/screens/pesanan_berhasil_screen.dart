import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/home_screen.dart';

class PesananBerhasilScreen extends StatefulWidget {
  static const String id = "pesanan_berhasil_screen";
  String code;
  PesananBerhasilScreen({Key key,this.code});

  @override
  _PesananBerhasilScreenState createState() => _PesananBerhasilScreenState();
}

class _PesananBerhasilScreenState extends State<PesananBerhasilScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          body: Container(
            margin: MediaQuery.of(context).padding,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xffF48262),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffF48262),
                        ),
                      ),
                      Text(
                        'Pesanan Berhasil',
                        style: TextStyle(
                          fontFamily: 'Yeseva',
                          fontSize: 22,
                          color: Color(0xffF48262),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xffF48262),
                    size: 75,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'TERIMA KASIH!',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Transaksi #'+widget.code,
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Pesananmu sudah kami terima.\nCek email untuk lihat bukti pembelanjaanmu.\nTerima kasih sudah berbelanja di Ponny Beaute.\nPhoebe tunggu review-mu'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: FlatButton(
                        color: Color(0xffF48262),
                        child: Text(
                          'BELANJA LAGI',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        onPressed: (){
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.id);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
