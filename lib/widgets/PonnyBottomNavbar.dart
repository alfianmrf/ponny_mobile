import 'package:flutter/material.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:provider/provider.dart';

class PonnyBottomNavbar extends StatelessWidget {
  PonnyBottomNavbar({this.selectedIndex});
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context,listen: true);
    _user.addListener(() {
      print(_user.loggedIn);
    });
    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          if (index != selectedIndex)
            Navigator.of(context).pushReplacementNamed(HomeScreen.id);
          break;
        case 3:
          if (index != selectedIndex)
            Navigator.of(context).pushReplacementNamed(ForumsScreen.id);
          break;
        case 4:
          print(_user.loggedIn);
          if (index != selectedIndex)
            _user.loggedIn ?
            Navigator.of(context).pushReplacementNamed(AccountScreen.id) :  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            );

          break;
        default:
          Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      }
    }

    return new Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color(0xffF48262),
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white))),
      child: new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Browse',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset_mic),
            title: Text(
              'Consultation',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            title: Text(
              'Forums',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(
              'Account',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
        ],
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
