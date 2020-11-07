import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Courier.dart';
import 'package:ponny/screens/account/tambah_alamat_screen.dart';
import 'package:ponny/screens/payment_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import 'account/edit_alamat_screen.dart';

class ShippingScreen extends StatefulWidget {
  static const String id = "shipping_screen";

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}


class _ShippingScreenState extends State<ShippingScreen> {
  bool isloading =true;
  MapCost _shipping;
  List<MapCost> valueOfcurier=[];
  int _valueOfcurier =-1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AddressModel>(context).getListAddress(Provider.of<AppModel>(context).auth.access_token).then((value) async {
        if(Provider.of<AddressModel>(context).useAddress !=null)
        await Provider.of<AddressModel>(context).getListCourier(Provider.of<AppModel>(context).auth.access_token);
        isloading=false;
      });

    });

  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15) ,
          child: Center(
              child: Text(
                'Pilih Metode Pengiriman Terlebih Dahulu!!',
                style: TextStyle(
                  fontFamily: 'Brandon',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xffF48262),
                ),
              )),
        ),

      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAllAdress(){
    showMaterialModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context, scrollController) => Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: Provider.of<AddressModel>(context).listAdress.length,
          itemBuilder: (BuildContext context, int index) {
            final address = Provider.of<AddressModel>(context).listAdress[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                width: 160.0,
                color: Colors.grey,
                child: GestureDetector(
                  onTap: (){
                    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                    Provider.of<AddressModel>(context).setDefaultAddress(address).then((value){
                      Provider.of<AddressModel>(context).getListCourier(Provider.of<AppModel>(context).auth.access_token).then((value){
                        UIBlock.unblock(context);
                        setState(() {
                          isloading=false;
                        });
                        Navigator.of(context).pop(true);
                      });
                    });
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 7),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.place,
                                      color: Color(0xffF48262),
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Alamat Pengiriman',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0xffF48262),
                                height: 1.0,
                                indent: 10,
                                //endIndent: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,top: 5),
                                child:Text(
                                  address.nama_depan+" "+address.nama_belakang,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ) ,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child:Text(
                                  address.alamat_lengkap,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child:Text(
                                  address.kecamatan+', '+address.city_name+','+address.province+','+address.postal_code,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child:Text(
                                  '+62'+address.nomor_hp,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.all(0.0),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );

  }





  @override
  Widget build(BuildContext context) {
    List<Widget> getCostwidget(){
      valueOfcurier=[];
      List<Widget> _tmp=[];
      int i =0;
      final listData= Provider.of<AddressModel>(context).listCourier;
      for(Courier courier in listData){
        for(Layanan layanan in courier.costs){
          for(Cost cost in layanan.cost){
            var _csnt = MapCost(i,courier.code,layanan.service,cost.value);
            valueOfcurier.add(_csnt);
              _tmp.add( Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffF48262),
                      width: 1.0,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Radio(
                          value: _csnt.index,
                          groupValue: _valueOfcurier,
                          onChanged: (value) {
                            setState(() {
                              _valueOfcurier =value;
                              _shipping = valueOfcurier[value];
                            });
                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                            Provider.of<CartModel>(context).AppyShipping(valueOfcurier[value],Provider.of<AppModel>(context).auth.access_token).then((value){
                              UIBlock.unblock(context);
                            });
                          },
                          activeColor: Color(0xffF48262),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courier.code.toUpperCase()+" "+layanan.service,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                cost.etd_text,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(cost.value),
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              );
              i++;
          }
        }
      }
      return _tmp;
    }
    final cart =Provider.of<CartModel>(context);

    return Consumer<AddressModel>(
        builder: (context,value,child){
          if(value.loading){
            return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Stack(children: <Widget>[
                  Scaffold(
                    backgroundColor: Color(0xffFDF8F0),
                    body:
                    Container(
                      margin: MediaQuery.of(context).padding,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xffF48262),
                                    ),
                                  ),
                                  Text(
                                    'Detail Pengiriman',
                                    style: TextStyle(
                                      fontFamily: 'Yeseva',
                                      fontSize: 22,
                                      color: Color(0xffF48262),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: LoadingWidgetFadingCircle(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                )
            );
          }else{
            if(value.useAddress != null){
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Stack(children: <Widget>[
                  Scaffold(
                    backgroundColor: Color(0xffFDF8F0),
                    body: Container(
                      margin: MediaQuery.of(context).padding,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xffF48262),
                                    ),
                                  ),
                                  Text(
                                    'Detail Pengiriman',
                                    style: TextStyle(
                                      fontFamily: 'Yeseva',
                                      fontSize: 22,
                                      color: Color(0xffF48262),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 7),
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(bottom: 7),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.place,
                                                    color: Color(0xffF48262),
                                                    size: 16,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5),
                                                    child: Text(
                                                      'Alamat Pengiriman',
                                                      style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              value.useAddress.nama_depan+" "+value.useAddress.nama_belakang,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              value.useAddress.alamat_lengkap,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              value.useAddress.kecamatan+', '+value.useAddress.city_name+','+value.useAddress.province+','+value.useAddress.postal_code,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '+62'+value.useAddress.nomor_hp,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                IconButton(
                                                  icon:Icon(Icons.edit),
                                                  color: Color(0xffF48262),
                                                  onPressed: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => EditAlamatScreen(address: value.useAddress), ),
                                                    );
                                                  },
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                ),
                                                IconButton(
                                                  onPressed: (){
                                                    Provider.of<AddressModel>(context).RemoveDefaultAddress();
                                                  },
                                                  icon: Icon(Icons.delete_outline),
                                                  color: Color(0xffF48262),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xffF48262),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: (){
                                                showAllAdress();
                                              },
                                              child:  Container(
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: Color(0xffF48262),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Pilih Alamat Lain',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                  ),
                                                ),
                                              ),
                                            )
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child:InkWell(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                child: Text(
                                                  'Tambah Alamat Baru',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => TambahAlamatScreen()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 7),
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(bottom: 7),
                                              child: Theme(
                                                  data: Theme.of(context).copyWith(
                                                    dividerColor: Colors.transparent,
                                                    accentColor: Colors.black,
                                                    unselectedWidgetColor: Colors.black,
                                                  ),
                                                  child:isloading?
                                                  Container( height: MediaQuery.of(context).size.width*.2, child: Center(child: LoadingWidgetFadingCircle(context),),):ListTileTheme(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                                    child: ExpansionTile(
                                                      initiallyExpanded: true,
                                                      title: Text(
                                                        'Pengiriman',
                                                        style: TextStyle(
                                                          fontFamily: 'Brandon',
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      trailing: Transform.rotate(
                                                        angle: 90 * math.pi / 180,
                                                        child: Icon(
                                                          Icons.chevron_right,
                                                          color: Color(0xffF48262),
                                                        ),
                                                      ),
                                                      children: getCostwidget(),
                                                    ),
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
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 25),
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: <Widget>[
                                      if(cart.summary != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'SUB TOTAL',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(cart.summary.subtotal,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(cart.coupon != null)
                                        Container(

                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'POTONGAN DISKON',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(cart.summary.discount,
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if(cart.shipping != null && _shipping != null)
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'BIAYA PENGIRIMAN',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              cart.summary.shipping?? "",
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      if(cart.shipping != null)
                                        Container(

                                          padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'GRATIS BIAYA PENGIRIMAN',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(cart.summary.free_shipping,
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      if(cart.summary != null)
                                      Container(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 5),
                                        margin: EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Color(0xffF48262),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'TOTAL PESANAN',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              cart.summary.total,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(cart.summary != null)
                                      Container(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 12),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xffF48262),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Poin yang didapat',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '+ '+cart.summary.earnPoint.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Gratis ongkir dengan pembelian minimal Rp 250.000',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 12,
                                              color: Color(0xffF48262),
                                            ),
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
                    ),
                  )
                ]),
                bottomNavigationBar: Wrap(
                  children: <Widget>[
                    if(cart.summary != null)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xfffdf8f0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.95,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'TOTAL PESANAN',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    cart.summary.total,
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: FlatButton(
                                    color: Color(0xffF48262),
                                    child: Text(
                                      'LANJUT PEMBAYARAN',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    onPressed: (){
                                      if(cart.shipping != null){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PaymentScreen()),
                                        );
                                      }else{
                                        showAlertDialog(context);
                                      }

                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new PonnyBottomNavbar(selectedIndex: 1),
                  ],
                ),
              );
            }else{
              return Scaffold(
                          backgroundColor: Theme.of(context).primaryColor,
                          body: Stack(children: <Widget>[
                          Scaffold(
                          backgroundColor: Color(0xffFDF8F0),
                          body:
                          Container(
                              margin: MediaQuery.of(context).padding,
                              child: SingleChildScrollView(
                                child: Column(
                                    children: <Widget>[
                                    Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                    Text(
                                      'Detail Pengiriman',
                                      style: TextStyle(
                                        fontFamily: 'Yeseva',
                                        fontSize: 22,
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*.8,
                                child: Center(
                                  child: FlatButton(
                                    onPressed: (){
                                      showAllAdress();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                        side: BorderSide(color: Color(0xffF48262))
                                    ),
                                    child: Text(
                                      '+ Pilih Default alamat Pengiriman',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                        ),
                      ),
                  ),
              ),
            ],
          )
      );
    }
  }
});


  }
}
