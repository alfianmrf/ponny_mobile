part of 'pages.dart';

class PickupPaymentSuccess extends StatefulWidget {

  @override
  _PickupPaymentSuccessState createState() => _PickupPaymentSuccessState();
}

class _PickupPaymentSuccessState extends State<PickupPaymentSuccess> {
  @override
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          titleSpacing: 20.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text(
            'Keranjang Belanja',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Yeseva',
              color: Hexcolor('#F48262'),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ));
  }
}
