part of 'pages.dart';

class ListTokoPengirimanScreen extends StatefulWidget {
  List<Cart> listCardOfitem=[];
  @override
  _ListTokoPengirimanScreenState createState() =>
      _ListTokoPengirimanScreenState();
}

class _ListTokoPengirimanScreenState extends State<ListTokoPengirimanScreen> {
  int _selectedIndex;
  Datum dataCabang;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getListToko();
    });
  }

  Future<void>getListToko() async{
      try{
          var token = Provider.of<AppModel>(context, listen: false).auth.access_token;
          print("sukses");
          await Provider.of<ListCabang>(context).getListCabang(token);
      }
      catch(e){
          print("ERror message"+e.toString());
      }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var method = Provider.of<ListCabang>(context);


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
            'PILIH TOKO',
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
          Consumer<ListCabang>(
            builder: (context, value, child){
              var cabang = value.dataCabang;
              return ListView.separated(
                itemCount: value.dataCabang.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Color(0xffF48262),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: Container(
                        color: _selectedIndex != null && _selectedIndex == index
                            ? Hexcolor('#FFF4DE')
                            : Hexcolor('#FCF8F0'),
                        padding: EdgeInsets.only(left: 16, top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cabang[index].alamatCabang,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              cabang[index].alamatCabang,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Jam Buka : Pukul ${cabang[index].jamOperasional} ${cabang[index].waktu} ",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.90),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                "Stok barang tersedia",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        _onSelected(index);
                        dataCabang = cabang[index];
                      });
                },
              );
            },
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Hexcolor('#FCF8F0'),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.064, vertical: 10),
                width: size.width,
                height: 60,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Color(0xffF48262),
                    child: Text(
                      "PILIH",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<ListCabang>(context).setDataCabang = dataCabang;
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }),
              ))
        ],
      ),
    );
  }
}
