//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/view/bottom_bar/item/category.dart';
import 'package:flutter_stickers_internet/app/view/bottom_bar/item/favorite.dart';

import 'HomePage.dart';
import 'MyStickers.dart';
import 'PerfilPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0; // index o tab inicial osea MyHomepage()
  List<Widget> _paginas = <Widget>[
//como esten ordenadas aqui las paginas estaran en las tabs son como urls
    MyHomePage(),
    CategoryItem(),
    PerfilPage(),
  ];

  void onItemTab(int index) {
    //si se quita este delayed la aplicacion crashea ya que el usuario sale y regresa de la tabs varias veces lo cual no le permite a la app cargar la data se cambiara por una animacion
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        currentPage = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _paginas.elementAt(currentPage)),
      //botones de navegacion osea tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        selectedItemColor: Colors.blue,
        onTap: onItemTab,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.apps_outlined)),
          BottomNavigationBarItem(
              label: 'Categories',
              icon: Stack(
                children: [
                  Icon(Icons.category_outlined),
                  // Positioned(
                  //   top: 0,
                  //   left: .0,
                  //   child: Container(
                  //     child: Text('12',
                  //         style: TextStyle(color: Colors.white, fontSize: 8)),
                  //     alignment: Alignment.center,
                  //     width: 15,
                  //     height: 15,
                  //     decoration: BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //     ),
                  //   ),
                  // )
                ],
              )),
          BottomNavigationBarItem(
            label: 'My Profile',
            icon: Icon(Icons.mood_outlined),
          ),
        ],
      ),
    );
  }
}
