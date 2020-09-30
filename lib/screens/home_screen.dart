import 'package:flutter/material.dart';
import 'package:ponny/screens/login.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
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
          Positioned(
            child: AppBar(
              title: Image.asset('assets/images/PonnyBeaute.png', fit: BoxFit.contain, height: 46,),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Icon(
                Icons.search,
              ),
              iconTheme: IconThemeData(
                color: Color(0xffF48262),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          )
        ]
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xffF48262),
          primaryColor: Colors.white,
          textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.white))
        ),
        child: new BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Brandon'
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(
                'Browse',
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Brandon'
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headset_mic),
              title: Text(
                'Consultation',
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Brandon'
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              title: Text(
                'Forums',
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Brandon'
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text(
                'Account',
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Brandon'
                ),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),

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

