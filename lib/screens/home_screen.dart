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
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    "http://via.placeholder.com/288x188",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 3,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              ),
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

