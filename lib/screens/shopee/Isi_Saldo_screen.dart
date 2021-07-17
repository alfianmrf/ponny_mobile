part of '../pages.dart';

class IsiSaldoScreen extends StatefulWidget {
  @override
  _IsiSaldoScreenState createState() => _IsiSaldoScreenState();
}

class _IsiSaldoScreenState extends State<IsiSaldoScreen> {
  @override
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
    );
  }
}
