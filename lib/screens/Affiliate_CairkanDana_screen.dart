import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/AffiliateWithdraw.dart';
import 'package:provider/provider.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/util/globalUrl.dart';

class CairkanDanaScreen extends StatefulWidget {
  static const String id = "Affiliate_CairkanDana_screen";
  final int total;
  final String img;
  CairkanDanaScreen({this.total, this.img});
  @override
  _CairkanDanaScreenState createState() => _CairkanDanaScreenState();
}

class _CairkanDanaScreenState extends State<CairkanDanaScreen> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  final norek = TextEditingController();
  final atasnama = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  String dropdownValue = 'Bank BCA';
  String bankName;
  bool dropPencairan = false;

  void withdrawSales() async {
    switch (dropdownValue) {
      case "Bank BCA":
        bankName = "bca";
        break;
      case "Bank Mandiri":
        bankName = "mandiri";
        break;
      case "Bank BRI":
        bankName = "bri";
        break;
      default:
    }

    FormState form = this.formKey.currentState;
    if (norek.text != "" && atasnama.text != "") {
      await Provider.of<AffiliateWithdraw>(context)
          .withdrawFund(bankName, norek.text, atasnama.text,
              Provider.of<AppModel>(context).auth.access_token)
          .then((value) {
        if (value == true) {
          scaffoldkey.currentState.showSnackBar(snackBarSuccess);
          Navigator.pop(context);
        } else {
          //ALERT
          scaffoldkey.currentState.showSnackBar(snackBarError);

          print("gagal");
        }
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                "Mohon maaf, silahkan lengkapi form yang kosong",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  makeSureWithdraw(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        withdrawSales();
        // print("atasnamaaa " + atasnama.text);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Withdraw Pendapatan ?"),
      content: Text("Apakah anda ingin withdraw pendapatan?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldkey,
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
            'Cairkan Dana',
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
                        width: size.width,
                        height: size.height * 0.28,
                        color: Colors.red,
                        child: CachedNetworkImage(
                          imageUrl: "$img_url${widget.img}",
                          placeholder: (context, url) =>
                              LoadingWidgetPulse(context),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/basic.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(20, 130, 20, 0),
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
                                              size: 14,
                                              color: Color(0xffF48262))
                                          : Icon(Icons.keyboard_arrow_down,
                                              size: 14,
                                              color: Color(0xffF48262)),
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
                                  child: Container(
                                      height: 50,
                                      child: TextFormField(
                                          controller: norek,
                                          keyboardType: TextInputType.phone,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          decoration: new InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintStyle: TextStyle(
                                              fontFamily: 'Brandon',
                                            ),
                                            focusedBorder:
                                                new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintText: "Nomor Rekening",
                                            enabledBorder:
                                                new OutlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                          )))),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: Text(
                                  'Nama Pemilik Rekening Tujuan*',
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
                                      "Nama Pemilik Rekening", null, atasnama)),
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
                                        FocusScope.of(context).unfocus();

                                        makeSureWithdraw(context);
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
                                      side: BorderSide(
                                          color: Hexcolor('#F48262')),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      )
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

Widget daftar_TextField(
    String hintText, Image prefiksIcon, TextEditingController value) {
  return Container(
    height: 50,
    child: TextFormField(
      controller: value,
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
