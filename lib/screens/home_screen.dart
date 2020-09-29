import 'package:flutter/material.dart';

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
  static const List<Widget> _widgetOptions = <Widget>[
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
    Text(
      'Index 4: Account',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
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