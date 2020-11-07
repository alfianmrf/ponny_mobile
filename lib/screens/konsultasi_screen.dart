import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:hexcolor/hexcolor.dart';

class KonsultasiScreen extends StatefulWidget {
  static const String id = "konsultasi_screen";
  @override
  _KonsultasiState createState() => _KonsultasiState();
}

class _KonsultasiState extends State<KonsultasiScreen> {
  int _currentPage = 0;
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor("#FDF9EE"),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 70, bottom: 70),
                color: Hexcolor("#FEEDE5"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "TANYA AHLI",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          color: Hexcolor("#F7866A"),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Kamu bisa konsultasi dengan dokter langsung \n melalui live chat",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                margin: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 220.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Hexcolor("#FFF9EF"),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 0);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Hexcolor("#F7866A"),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Beli",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color:
                                        (_currentPage == 0 || _currentPage == 4)
                                            ? Hexcolor("#F7866A")
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 1);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Hexcolor("#F7866A"),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.money,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Voucher Saya",
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 1)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 2);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Hexcolor("#F7866A"),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.update,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Riwayat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 2)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 3);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Hexcolor("#F7866A"),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.people_alt,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Komunikasi",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 3)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraint) {
              switch (_currentPage) {
                case 0:
                  {
                    return beli();
                  }
                case 1:
                  {
                    return voucher_saya();
                  }
                case 2:
                  {
                    return riwayat();
                  }
                case 3:
                  {
                    return komunikasi_screen();
                  }
                case 4:
                  {
                    return tambah_beli();
                  }
                default:
                  {
                    return Container(
                      child: Text("Halaman tidak ada"),
                    );
                  }
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 2),
    );
  }

  Widget beli() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          "https://via.placeholder.com/288x188",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "VOUCHER KONSULTASI",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Hexcolor("#F7866A"),
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "1 Menit",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "Rp. 20.000",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() => _currentPage = 4);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Hexcolor("#F7866A"),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(
                                    "PAKAI",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Expired 30-10-2020",
                      style: TextStyle(
                        color: Hexcolor("#F7866A"),
                        fontFamily: "Brandon",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget voucher_saya() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 40, left: 40),
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  "Ups, kamu belum punya voucher konsultasi",
                  style: TextStyle(
                    fontFamily: "Brandon",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() => _currentPage = 0);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 165),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Hexcolor("#F7866A"),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.only(top: 3, bottom: 3),
                        width: 100,
                        child: Text(
                          "BELI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget riwayat() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          color: Hexcolor("#F7866A"),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    "ORDER",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "TANGGAL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    "STATUS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "TOTAL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Hexcolor("#F7866A"),
                width: 2,
              ),
            ),
          ),
          margin: EdgeInsets.only(right: 25, left: 25),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "#70212",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "29/04/2020",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Belum dibayar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Rp 329.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Hexcolor("#FEEDE5"),
                    ),
                    child: Text(
                      "BELUM TERPAKAI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Hexcolor("#F7866A"),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("Payment Method \n BCA Virtual",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Hexcolor("#F7866A"),
                width: 2,
              ),
            ),
          ),
          margin: EdgeInsets.only(right: 25, left: 25),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "#70212",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "29/04/2020",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Telah dibayar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Rp 329.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Hexcolor("#FEEDE5"),
                    ),
                    child: Text(
                      "BELUM TERPAKAI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Hexcolor("#F7866A"),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("Payment Method \n BCA Virtual",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Hexcolor("#F7866A"),
                width: 2,
              ),
            ),
          ),
          margin: EdgeInsets.only(right: 25, left: 25),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "#70212",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "29/04/2020",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Telah dibayar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Rp 329.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 3, bottom: 3, right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Hexcolor("#FEEDE5"),
                    ),
                    child: Text(
                      "BELUM TERPAKAI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Hexcolor("#F7866A"),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("Payment Method \n BCA Virtual",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget tambah_beli() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          "https://via.placeholder.com/288x188",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "VOUCHER KONSULTASI",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Hexcolor("#F7866A"),
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "1 Menit",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "Rp. 20.000",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          return decrementCounter();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Hexcolor("#F7866A"),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50),
                                            ),
                                          ),
                                          height: 20,
                                          child: Text("-",
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Hexcolor("#F7866A"),
                                            ),
                                            top: BorderSide(
                                              color: Hexcolor("#F7866A"),
                                            ),
                                          ),
                                        ),
                                        height: 20,
                                        child: Text('$counter',
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          return incrementCounter();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Hexcolor("#F7866A"),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50),
                                              bottomRight: Radius.circular(50),
                                            ),
                                          ),
                                          height: 20,
                                          child: Text("+",
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Masa Berlaku 30 Hari",
                      style: TextStyle(
                        color: Hexcolor("#F7866A"),
                        fontFamily: "Brandon",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Hexcolor("#F7866A"),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  margin: EdgeInsets.only(left: 40, right: 40),
                  width: 100,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "BELI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Br4andon",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class komunikasi_screen extends StatefulWidget {
  @override
  _KomunikasiState createState() => _KomunikasiState();
}

class _KomunikasiState extends State<komunikasi_screen> {
  int _komunikasiPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 40, left: 40),
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _komunikasiPage = 0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Hexcolor("#F7866A"),
                      ),
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        "BELI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _komunikasiPage = 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Hexcolor("#F7866A"),
                      ),
                      padding: EdgeInsets.only(top: 3, bottom: 3),
                      child: Text(
                        "TUKAR",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _komunikasiPage = 2);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Hexcolor("#F7866A"),
                      ),
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "KONSULTASI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraint) {
              switch (_komunikasiPage) {
                case 0:
                  {
                    return beli_screen();
                  }
                case 1:
                  {
                    return tukar_screen();
                  }
                case 2:
                  {
                    return konsultasi_screen();
                  }
                default:
                  return Container(
                    child: Text("Halaman Kosong"),
                  );
              }
            },
          ),
          SizedBox(height: 70),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Hexcolor("#F7866A"),
                  width: 2,
                ),
              ),
            ),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "FAQs",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Yeseva",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Flexible(
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: ExpansionTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      "Bagaimana cara berkonsultasi ?",
                      style: new TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          top: BorderSide(
                            color: Hexcolor("#F7866A"),
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Happy Skin Reward adalah program reward di mana Anda dapat menjadi anggota membership Pony Beaute. Sebagai Anggota, anda harus mempunyai akun, sehingga dapat mengumpulkan poin, menukarkan poin dengan hadiah, mendapat beragam keuntungan diskon dan promosi lainnya yang secara eksklusif diberikan untuk anggota, serta informasi kecantikan lainnya.",
                              style: new TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Flexible(
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: Border(
                  top: BorderSide(color: Hexcolor("#F7866A"), width: 2),
                ),
                child: ExpansionTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      "Apa itu Happy Skin Reward ?",
                      style: new TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          top: BorderSide(
                            color: Hexcolor("#F7866A"),
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Happy Skin Reward adalah program reward di mana Anda dapat menjadi anggota membership Pony Beaute. Sebagai Anggota, anda harus mempunyai akun, sehingga dapat mengumpulkan poin, menukarkan poin dengan hadiah, mendapat beragam keuntungan diskon dan promosi lainnya yang secara eksklusif diberikan untuk anggota, serta informasi kecantikan lainnya.",
                              style: new TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Flexible(
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: Border(
                  top: BorderSide(color: Hexcolor("#F7866A"), width: 2),
                ),
                child: ExpansionTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      "Apa itu Happy Skin Reward ?",
                      style: new TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          top: BorderSide(
                            color: Hexcolor("#F7866A"),
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Happy Skin Reward adalah program reward di mana Anda dapat menjadi anggota membership Pony Beaute. Sebagai Anggota, anda harus mempunyai akun, sehingga dapat mengumpulkan poin, menukarkan poin dengan hadiah, mendapat beragam keuntungan diskon dan promosi lainnya yang secara eksklusif diberikan untuk anggota, serta informasi kecantikan lainnya.",
                              style: new TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class beli_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Beli",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "Dolor enim sit amet ex pariatur ullamco adipisicing consequat occaecat irure officia dolor. Voluptate ad nostrud pariatur sit dolor irure incididunt proident. Non anim amet voluptate sint officia ut anim et magna aute cupidatat nisi eiusmod anim. Eu consectetur nostrud excepteur eu est cupidatat cillum irure mollit cillum. Minim sunt commodo in pariatur commodo qui adipisicing culpa.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#F7866A"),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(right: 40, left: 40),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Yuk, Mulai Konsultasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Brandon",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class tukar_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Tukar",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "Dolor enim sit amet ex pariatur ullamco adipisicing consequat occaecat irure officia dolor. Voluptate ad nostrud pariatur sit dolor irure incididunt proident. Non anim amet voluptate sint officia ut anim et magna aute cupidatat nisi eiusmod anim. Eu consectetur nostrud excepteur eu est cupidatat cillum irure mollit cillum. Minim sunt commodo in pariatur commodo qui adipisicing culpa.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#F7866A"),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(right: 40, left: 40),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Yuk, Mulai Konsultasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Brandon",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class konsultasi_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(2, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Konsultasi",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "Dolor enim sit amet ex pariatur ullamco adipisicing consequat occaecat irure officia dolor. Voluptate ad nostrud pariatur sit dolor irure incididunt proident. Non anim amet voluptate sint officia ut anim et magna aute cupidatat nisi eiusmod anim. Eu consectetur nostrud excepteur eu est cupidatat cillum irure mollit cillum. Minim sunt commodo in pariatur commodo qui adipisicing culpa.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#F7866A"),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(right: 40, left: 40),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Yuk, Mulai Konsultasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Brandon",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
