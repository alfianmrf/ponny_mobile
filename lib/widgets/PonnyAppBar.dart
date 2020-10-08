import 'package:flutter/material.dart';
import 'package:ponny/screens/cart_screen.dart';

class PonnyAppBar extends StatelessWidget implements PreferredSizeWidget{
  PonnyAppBar();
  @override
  Size get preferredSize => const Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      primary: false,
      title: Image.asset('assets/images/PonnyBeaute.png', fit: BoxFit.contain, height: 46),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
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
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(CartScreen.id);
          },
        ),
      ],
    );
  }
}