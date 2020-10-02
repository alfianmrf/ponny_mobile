import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/screens/login.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/widgets/PonnyAppBar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[

      Text(
        'Index 1: Browse',
        style: optionStyle,
      ),
      Text(
        'Index 2: Consultation',
        style: optionStyle,
      ),
      Text(
        'Index 3: Forums',
        style: optionStyle,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Hello World!', style: TextStyle(fontSize: 28, color: Colors.black)),
          RaisedButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    LoginScreen()),
              );
            },
            textColor: Colors.deepOrange,
            padding: const EdgeInsets.all(0.0),
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D474A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5)
                      ]
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text('Login!', style: TextStyle(fontSize: 31),)
            ),
          )
        ],
      ),
    ];
    Row flatButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text('Saya FlatButton'),
          onPressed: () => debugPrint('FlatButton di tekan'),
        )
      ],
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            extendBodyBehindAppBar: true,
            appBar: new PonnyAppBar(),
            body: new Container(
              color: Theme.of(context).primaryColor,
              child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.network(
                              "http://via.placeholder.com/288x188",
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: 3,
                          pagination: new SwiperPagination(
                              margin: new EdgeInsets.all(5.0),
                              builder: new DotSwiperPaginationBuilder(
                                  color: Color(0xffE6E7E9), activeColor: Color(0xffF48262))
                          ),
                          control: null,
                          autoplay: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Best Seller',
                          style: TextStyle(
                            fontFamily: 'Yeseva',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 135,
                        color: Colors.blue,
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return GridView.count(
                              primary: false,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                              crossAxisCount: 3,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/produk.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                                              child: const Text(
                                                '35%',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Brandon'
                                                ),
                                              ),
                                            ),
                                            color: Color(0xffF48262),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: const Text(
                                          'ADD TO BAG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Brandon'
                                          ),
                                        ),
                                        color: Color(0xffF3C1B5),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/produk.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: const Text(
                                          'ADD TO BAG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Brandon'
                                          ),
                                        ),
                                        color: Color(0xffF3C1B5),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/produk.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: const Text(
                                          'ADD TO BAG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Brandon'
                                          ),
                                        ),
                                        color: Color(0xffF3C1B5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          itemCount: 3,
                          pagination: null,
                          control: null,
                          autoplay: false,
                        ),
                      ),
                    ],
                  )
              )
            ),
          ),
        ]
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
    );
  }
}
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

