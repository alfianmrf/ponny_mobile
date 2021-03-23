import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account/affiliate_us_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:intl/intl.dart';

class CairkanDanaScreen extends StatefulWidget {
  static const String id = "Affiliate_CairkanDana_screen";
  int total;
  CairkanDanaScreen({this.total});
  @override
  _CairkanDanaScreenState createState() => _CairkanDanaScreenState();
}

class _CairkanDanaScreenState extends State<CairkanDanaScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  String dropdownValue = 'Bank BCA';
  bool dropPencairan = false;

  @override
  void withdrawSales() {
    print("drop" + dropdownValue);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffF48262),
              size: 26,
            ),
          ),
          title: Text(
            'Dalam Perjalanan',
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Yeseva",
              fontWeight: FontWeight.w500,
              color: Color(0xffF48262),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          "https://via.placeholder.com/288x188",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Hexcolor('#FCF8F0'),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                "CAIRKAN DANA",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Yeseva",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    'Ketentuan pencairan dana',
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffF48262),
                                    ),
                                  ),
                                  IconButton(
                                    icon: dropPencairan
                                        ? Icon(Icons.keyboard_arrow_up,
                                            size: 14, color: Color(0xffF48262))
                                        : Icon(Icons.keyboard_arrow_down,
                                            size: 14, color: Color(0xffF48262)),
                                    onPressed: () {
                                      setState(() {
                                        dropPencairan = !dropPencairan;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            dropPencairan
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Text(
                                      '• Masukan nomor rekening dan nama pemilik rekening dengan benar.\n• Dana akan ditransfer ke rekening yang tertera di bawah ini dalam waktu 3x24 jam.\n• Konfirmasi pencairan dana akan dikirimkan melalui email yang terdaftar',
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              child: ListTile(
                                leading: Container(
                                  height: double.infinity,
                                  child: ImageIcon(
                                    AssetImage('assets/images/wallet.png'),
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                title: Align(
                                  alignment: Alignment(-1.2, 0),
                                  child: Text(
                                    'TOTAL',
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                subtitle: Align(
                                  alignment: Alignment(-1.3, 0),
                                  child: Text(
                                    '${formatCurrency.format(widget.total)}',
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Text(
                                'Pilih Bank*',
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  underline: null,
                                  value: dropdownValue,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  elevation: 16,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Bank BCA',
                                    'Bank Mandiri',
                                    'Bank Permata',
                                    'Bank BRI'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Text(
                                'Nomor Rekening Tujuan*',
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child:
                                    daftar_TextField("Nomor Rekening", null)),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: Text(
                                'Nomor Rekening Tujuan*',
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: daftar_TextField(
                                    "Nama Pemilik Rekening", null)),
                            Container(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
                                child: ButtonTheme(
                                  buttonColor: Hexcolor('#F48262'),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: RaisedButton(
                                    elevation: 0,
                                    onPressed: () {
                                      // int count = 0;
                                      // Navigator.of(context)
                                      //     .popUntil((_) => count++ >= 2);
                                      withdrawSales();
                                    },
                                    child: Text(
                                      "CAIRKAN",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1,
                                          color: Colors.white),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                  ),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}

Widget daftar_TextField(String hintText, Image prefiksIcon) {
  return Container(
    height: 50,
    child: TextField(
      textAlignVertical: TextAlignVertical.bottom,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontFamily: 'Brandon',
        ),
        focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        prefixIcon: prefiksIcon,
        enabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
      ),
    ),
  );
}
