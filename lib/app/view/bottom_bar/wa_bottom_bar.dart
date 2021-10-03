import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/view/searchbar/wa_app_bar.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';

import 'item/category.dart';
import 'item/dashboard.dart';
import 'item/favorite.dart';

class WaBottomBar extends StatefulWidget {

  @override
  _EbookBottomBarState createState() => _EbookBottomBarState();
}

class _EbookBottomBarState extends State<WaBottomBar> with TickerProviderStateMixin {

  //check purchased and iau
  late Animation<double> animation;
  late AnimationController _animationController;
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  bool updateAvailable = false;
  bool isPurchased = false;
  int _currentIndex = 0;
  late PageController _pageController;
  late ScrollController _scrollController;
  bool buttonBottomTop = false;

  List<Widget> bodys() => [
    Dashboard(scrollController: _scrollController,),
    CategoryItem(),
    Favorite()
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..addListener(() {setState(() {
    });});
    animation = Tween(begin: kTextTabBarHeight, end: 0.0).animate(_animationController);
    _pageController = PageController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(_scrollController.hasClients){
        _scrollController.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.easeOut);
      }
    });
    _scrollController = ScrollController()..addListener(() {setState(() {
      if(_scrollController.offset >= 350){
        buttonBottomTop = true;
      }else{
        buttonBottomTop = false;
      }
    });});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void backToTop(){
    _scrollController.animateTo(0, duration: Duration(milliseconds: 2000), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = bodys();
    return Scaffold(
      appBar: PreferredSize(
          child: WaAppBar(),
          preferredSize: Size.fromHeight(animation.value)),
      bottomNavigationBar: Wrap(
        children: [Container(
          height: animation.value,
          child: BottomNavigationBar(
            onTap: onTapBM,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: getColorFromHex(GlobalColors().colorWhite),
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home, color: getColorFromHex(GlobalColors().activeIconDefault),),
                title: Text('Home', style: TextStyle(color: getColorFromHex(GlobalColors().fireColor)),),
                activeIcon: new Icon(Icons.local_fire_department, color: getColorFromHex(GlobalColors().fireColor),),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.category_outlined, color: getColorFromHex(GlobalColors().activeIconDefault),),
                title: Text('Category', style: TextStyle(color: getColorFromHex(GlobalColors().activeIconBottom))),
                activeIcon: new Icon(Icons.category, color: getColorFromHex(GlobalColors().activeIconBottom),),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite_border, color: getColorFromHex(GlobalColors().activeIconDefault),),
                title: Text('Favorites', style: TextStyle(color: getColorFromHex(GlobalColors().heartColor))),
                activeIcon: new Icon(Icons.favorite, color: getColorFromHex(GlobalColors().heartColor),),
              ),
            ],
          ),
        )],
      ),
      floatingActionButton: Container(
        width: 50.0,
        height: 50.0,
        child: Center(
          child: FittedBox(
            child: !buttonBottomTop ? null : FloatingActionButton(
              onPressed: () {
                backToTop();
              },
              child: Icon(Icons.arrow_upward),
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (anim){
          if((anim.scrollDelta! < 0) && (animation.isDismissed)){
            _animationController.forward();
            return true;
          }else if((anim.scrollDelta! > 0) && (animation.isCompleted)){
            _animationController.reverse();
            return true;
          }
          return false;
        },
        child: body[_currentIndex],
      )
    );
  }

  void onTapBM(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
