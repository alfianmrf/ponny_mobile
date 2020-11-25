import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class SyaratKetentuanScreen extends StatefulWidget {
  static const String id = "Syarat_Ketentuan_screen";

  @override
  _SyaratKetentuanScreenState createState() => _SyaratKetentuanScreenState();
}

class _SyaratKetentuanScreenState extends State<SyaratKetentuanScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: Column(
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
                        "Syarat & Ketentuan",
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
              Expanded(
                              child: SingleChildScrollView(
                                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, right: 20, left: 20,bottom:30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                          child: Text(
                            "Syarat & ketentuan yang ditetapkan di bawah ini mengatur pemakaian jasa yang ditawarkan oleh Ponny beaute terkait pembelian di situs www.ponnybeaute.co.id/. Dengan mendaftar dan/atau menggunakan situs www.ponnybeaute.co.id/, maka pengguna dianggap telah membaca, mengerti, memahami dan menyutujui semua isi dalam Syarat & ketentuan.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(height: 10),
                        Container(
                          child: Text(
                            "1. Ponnybeaute tidak memungut biaya pendaftaran kepada Pengguna.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "2. Pembeli wajib bertransaksi melalui prosedur transaksi yang telah ditetapkan oleh Ponnybeaute. Pembeli melakukan pembayaran dengan menggunakan metode pembayaran yang sebelumnya telah dipilih oleh Pembeli.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "3. Pembeli memahami dan mengerti bahwa Ponnybeaute telah melakukan usaha sebaik mungkin dalam memberikan informasi tarif pengiriman kepada Pembeli berdasarkan lokasi secara akurat, namun Kami tidak dapat menjamin keakuratan data tersebut dengan yang ada pada cabang setempat.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "4. Pengiriman pesanan dilakukan 1 (satu) hari setelah pembayaran diselesaikan.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "5. Pembeli menerima informasi nomor resi dalam kurun waktu 36 jam setelah pembayaran diselesaikan.",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 14,
                            ),
                          ),
                        ),

                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}

Widget syaratKetentuanText() {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1. General",
          style: TextStyle(
            fontFamily: 'Brandon',
            fontSize: 14,
          ),
        ),
        Container(height: 10),
        Text(
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.",
          style: TextStyle(
            fontFamily: 'Brandon',
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}
