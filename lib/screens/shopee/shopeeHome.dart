part of '../pages.dart';

class ShopeeHomeScreen extends StatefulWidget {
  @override
  _ShopeeHomeScreenState createState() => _ShopeeHomeScreenState();
}

class _ShopeeHomeScreenState extends State<ShopeeHomeScreen> {
  List<ShopeeListFilter> riwayat = [
    ShopeeListFilter(name: "Semua"),
    ShopeeListFilter(name: "Pembayaran"),
    ShopeeListFilter(name: "Pengambilan"),
    ShopeeListFilter(name: "Dana Keluar"),
  ];

  List<ShopeeListFilter> filter = [
    ShopeeListFilter(name: "Semua", status: false),
    ShopeeListFilter(name: "Hari ini", status: false),
    ShopeeListFilter(name: "Minggu ini", status: false),
    ShopeeListFilter(name: "Bulan ini", status: false),
    ShopeeListFilter(name: "Bulan lalu", status: false),
    ShopeeListFilter(name: "Custom", status: false),
  ];

  void _detailModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Pilih Filter",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(FlutterIcons.close_ant,
                                        color: Color(0xffF48262))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Color(0xffF48262)),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filter.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(filter[index].name),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                      border: Border.all(
                                          color: Color(0xffF48262), width: 2)),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xffF48262),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              margin: EdgeInsets.only(right: 8),
                              child: Image.asset(
                                  'assets/images/shopeeIcons/shopeeCalendar.png'),
                            ),
                            Text("30 Maret 2021 - 01 Agustus 2021"),
                            Spacer(),
                            Icon(
                              FlutterIcons.expand_more_mdi,
                              color: Color(0xffF48262),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        child: RaisedButton(
                          elevation: 0,
                          textColor: Color(0xfffdf8f0),
                          color: Color(0xffF48262),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text("Gunakan"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF48262),
            size: 26,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ShopeePay",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Yeseva",
                fontWeight: FontWeight.w500,
                color: Color(0xffF48262),
              ),
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Icon(FlutterIcons.setting_ant,
                        color: Color(0xffF48262))))
          ],
        ),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xffF48262),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
      ),
      backgroundColor: Color(0xfffdf8f0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xffF48262),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Saldo ShopeePay",
                      style: TextStyle(color: Color(0xfffdf8f0), fontSize: 12)),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        width: 26,
                        child: Image.asset(
                            'assets/images/shopeeIcons/shopeeWalletWht.png'),
                      ),
                      Text("Rp. 1.000.000",
                          style: TextStyle(
                              color: Color(0xfffdf8f0),
                              fontWeight: FontWeight.w600,
                              fontSize: 16))
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
              decoration: BoxDecoration(
                  color: Color(0xfffeede4),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          width: 60,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Image.asset(
                                  'assets/images/shopeeIcons/walletPlus.png'),
                            ),
                          ),
                        ),
                        Container(child: Text("Isi Saldo"))
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Image.asset(
                            'assets/images/shopeeIcons/shopeeQR.png'),
                      ),
                      Container(child: Text("Scan"))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Image.asset(
                            'assets/images/shopeeIcons/walletArrow.png'),
                      ),
                      Container(
                        child: Text("Transfer"),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xfffeede4),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "Riwayat Transaksi",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _detailModalBottomSheet(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: Color(0xffF48262),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(
                            FlutterIcons.expand_more_mdi,
                            color: Color(0xffF48262),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: riwayat.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              color: Color(0xffF48262),
                            ),
                          ),
                          child: Text(riwayat[index].name),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    child: ListView.builder(
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 35,
                                  child: Image.asset(
                                      'assets/images/shopeeIcons/shopeeNote.png')),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pembayaran",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        "Dengan ShopeePay",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "12/01/2021 12:40",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500]),
                                      )
                                    ]),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  "-251.000",
                                  style: TextStyle(
                                      color: Color(0xffF48262),
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
