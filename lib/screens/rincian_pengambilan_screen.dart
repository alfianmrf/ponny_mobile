part of 'pages.dart';

class RincianPengambilanScreen extends StatefulWidget {
  @override
  _RincianPengambilanScreenState createState() =>
      _RincianPengambilanScreenState();
}

class _RincianPengambilanScreenState extends State<RincianPengambilanScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var rincian = Provider.of<ListCabang>(context);
    var rincianTotal =  Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Hexcolor('#FCF8F0'),
      appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Color(0xffF48262), size: 26)),
          title: Text(
            'Rincian Pengambilan',
            style: TextStyle(
                fontSize: 24,
                fontFamily: "Yeseva",
                fontWeight: FontWeight.w500,
                color: Color(0xffF48262)),
          ),
          bottom: PreferredSize(
              child: Container(color: Color(0xffF48262), height: 1.0),
              preferredSize: Size.fromHeight(1.0))),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color(0xffF48262).withOpacity(0.32)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin:
                    EdgeInsets.only(left: 14, top: 10, bottom: 10, right: 14),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xffF48262),
                        ),
                        SizedBox(width: 3),
                        Text(
                          "Pick up in store",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      rincian.cabangClick.namaCabang,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      rincian.cabangClick.alamatCabang,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Jam Buka : Pukul ${rincian.cabangClick.jamOperasional} ${rincian.cabangClick.waktu} ",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Nanti tim ponny beaute akan kirim e-mail kalau pesananmu siap diambil",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          color: Color(0xffF48262),
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Color(0xffF48262).withOpacity(0.32)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin:
                    EdgeInsets.only(left: 14, top: 10, bottom: 10, right: 14),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBuild(
                          value: "SUB TOTAL",
                        ),
                        TextBuild(
                          value: rincianTotal.summary.subtotal,
                        )
                      ],
                    ),
                    rincianTotal.summary.discount == "Rp0" ? SizedBox() : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBuild(
                          value: "POTONGAN DISKON",
                        ),
                        TextBuild(
                          value: rincianTotal.summary.discount,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBuild(
                          value: "POIN DIPAKAI",
                          warna: Color(0xffF48262),
                        ),
                        TextBuild(
                          value: "+2.000",
                          warna: Color(0xffF48262),
                        )
                      ],
                    ),
                    Divider(
                      color: Color(0xffF48262),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBuild(
                          value: "TOTAL PESANAN",
                          weight: FontWeight.w600,
                        ),
                        TextBuild(
                          value: rincianTotal.summary.total,
                          weight: FontWeight.w600,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Hexcolor('#FCF8F0'),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -1),
                          blurRadius: 2,
                          color: Colors.grey.shade300)
                    ]),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.064, vertical: 10),
                width: size.width,
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextBuild(
                          value: "TOTAL PESANAN",
                          weight: FontWeight.w600,
                        ),
                        TextBuild(
                          value: rincianTotal.summary.total,
                          weight: FontWeight.w600,
                        )
                      ],
                    ),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: Color(0xffF48262),
                        child: Text(
                          "LANJUT PEMBAYARAN",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PaymentScreen()),
                          );
                        }),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class TextBuild extends StatelessWidget {
  const TextBuild({Key key, this.value, this.weight, this.warna, this.size})
      : super(key: key);
  final String value;
  final FontWeight weight;
  final Color warna;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontWeight: weight,
        fontFamily: "Brandon",
        color: warna,
        fontSize: size,
      ),
    );
  }
}
