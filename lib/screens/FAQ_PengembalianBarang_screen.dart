import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/screens/FAQ_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_TopQuestion_screen.dart';

class PengembalianBarang extends StatefulWidget {
  static const String id = "FAQ_PengembalianBarang_screen";
  Faq faq;
  PengembalianBarang({Key key,this.faq});

  @override
  _PengembalianBarangState createState() => _PengembalianBarangState();
}

class _PengembalianBarangState extends State<PengembalianBarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 35,
              ),
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
                        "",
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
                          widget.faq.ask,
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
                        widget.faq.ans,
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
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        FAQScreen.id,(_) => false
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
