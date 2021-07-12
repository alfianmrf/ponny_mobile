import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class PilihSample extends StatefulWidget {

  @override
  PilihSampleState   createState() => PilihSampleState();
}

class PilihSampleState extends State<PilihSample>{
  GlobalKey<ScaffoldState> scafoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getSample();
    });
  }

  Future<void> getSample() async {
    try {
      var token = Provider.of<AppModel>(context, listen: false).auth.access_token;
      var cabangid = Provider.of<ListCabang>(context).cabangClick.id;
      await Provider.of<CartModel>(context).getSample(token, cabangid);
    } catch (e) {
      print("Error message : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
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
        title:  Text(
          "PILIH SAMPLE",
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
      backgroundColor: Color(0xffFDF8F0),
      body: Provider.of<CartModel>(context).loadingSample ? Center(child: LoadingWidget(context),) : CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid.count(
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children:Provider.of<CartModel>(context).listSample.map((e){
                return GestureDetector(
                  onTap: (){
                     UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                     Provider.of<CartModel>(context).addSampleToCart(e, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
                       UIBlock.unblock(context);
                       Navigator.pop(context);
                     }).catchError((onError){
                       UIBlock.unblock(context);
                       print(onError);
                     });
                  },
                  child:  Container(
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 140,
                          margin: EdgeInsets.only(bottom: 5),
                          child:CachedNetworkImage(
                            imageUrl: img_url+e.thumbnail_image,
                            placeholder: (context, url) => LoadingWidgetPulse(context),
                            errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          e.brand.name,
                          style: TextStyle(
                            fontFamily: "Yeseva",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          e.name.length > 25 ? e.name.substring(0,25)+"..." : e.name,
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Gratis",
                          style: TextStyle(
                            fontFamily: "Yeseva",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                    ),
                  ),
                );
              }).toList()
            ),
          ),
        ],
      ),
    );
  }
  
  
}