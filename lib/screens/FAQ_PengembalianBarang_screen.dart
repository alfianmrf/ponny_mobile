import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class PengembailanBarang extends StatefulWidget {
  PengembailanBarang({Key key}) : super(key: key);

  @override
  _PengembailanBarangState createState() => _PengembailanBarangState();
}

class _PengembailanBarangState extends State<PengembailanBarang> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          )),
                    ),
                    Container(
                      child: Text(
                        "Pengembalian Barang",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffF48262),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "What is the return and exchange policy?",
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 1,
                        color: Color(0xffF48262),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi",
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 14,
                        ),
                      ),
                    ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: FlatButton(
                  color: Color(0xffF48262),
                  child: Text(
                    'KEMBALI KE FAQ',
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
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)
      ),
    );
  }
}
