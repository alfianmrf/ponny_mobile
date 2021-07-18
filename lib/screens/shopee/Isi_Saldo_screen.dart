part of '../pages.dart';

class IsiSaldoScreen extends StatefulWidget {
  @override
  _IsiSaldoScreenState createState() => _IsiSaldoScreenState();
}

class _IsiSaldoScreenState extends State<IsiSaldoScreen> {
  @override
  int _activeMeterIndex;
  final formatCurrency =
      new NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  List<ShopeeListFilter> price = [
    ShopeeListFilter(price: 50000),
    ShopeeListFilter(price: 100000),
    ShopeeListFilter(price: 250000),
    ShopeeListFilter(price: 500000),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdf8f0),
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Theme(
                data: ThemeData(
                    primaryColor: Color(0xffF48262),
                    accentColor: Color(0xffF48262),
                    hintColor: Color(0xffF48262)),
                child: new TextField(
                  decoration: new InputDecoration(
                      labelText: "Nominal",
                      hintText: "Rp 50.000",
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Brandon'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF48262)),
                      ),
                      border: new UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF48262)))),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: price.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Color(0xffF48262),
                      ),
                    ),
                    child: Text(formatCurrency.format(price[index].price),
                        style: TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
            Container(
              child: Text(
                "Pembayaran",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Color(0xfffdf8f0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(cardColor: Color(0xfffdf8f0)),
                      child: new ExpansionPanelList(
                        dividerColor: Color(0xffF48262),
                        elevation: 0,
                        expansionCallback: (int i, bool status) {
                          setState(() {
                            _activeMeterIndex =
                                _activeMeterIndex == index ? null : index;
                          });
                        },
                        children: [
                          new ExpansionPanel(
                            isExpanded: _activeMeterIndex == index,
                            headerBuilder: (BuildContext context,
                                    bool isExpanded) =>
                                new Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          margin: EdgeInsets.only(right: 16),
                                          child: Image.asset(
                                              'assets/images/shopeeIcons/shopeeTransfer.png'),
                                        ),
                                        Text(
                                          "Transfer Bank",
                                        ),
                                      ],
                                    )),
                            body: new Container(
                              margin: EdgeInsets.only(left: 57),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int value) {
                                  return Row(
                                    children: [
                                      Text("List 1-1"),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                child: Row(
              children: [
                Container(
                  width: 50,
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset('assets/images/payment/alfamart-02.png'),
                ),
                Text(
                  "Alfamart / Alfamidi",
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
