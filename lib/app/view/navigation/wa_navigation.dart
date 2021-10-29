// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class WaNavigation extends StatefulWidget {

//   final String image, email, name, id;

//   WaNavigation({required this.image, required this.email, required this.name, required this.id});

//   @override
//   _EbookProfileState createState() => _EbookProfileState();
// }

// class _EbookProfileState extends State<WaNavigation> with SingleTickerProviderStateMixin{
//   GlobalKey<ScaffoldState> global = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final ebookTheme = Provider.of<EbookTheme>(context);
//     return Scaffold(
//       key: global,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 1, bottom: 1, right: 10),
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: new DecorationImage(
//                             fit: BoxFit.cover,
//                             image: new NetworkImage(
//                                 widget.image),
//                           )
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.name,
//                         style: TextStyle(
//                           color: Colors.black, //ebookTheme.themeMode().textColor,
//                           fontSize: 18,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                       Text(
//                         widget.email,
//                         style: TextStyle(
//                           color: Colors.black, //ebookTheme.themeMode().textColor,
//                           fontSize: 18,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             // Divider(color: getColorFromHex("FFFFFF"),),
//             // NavigationDrawerItemList(
//             //   title: DemoLocalizations.of(context).translate('home'),
//             //   icons: Icon(Icons.home, color: ebookTheme.themeMode().iconColor,),
//             //   onTap: ()=>pushPage(context, EbookBottomBar(null, null)),
//             // ),
//             // NavigationDrawerItemList(
//             //   title: DemoLocalizations.of(context).translate('library'),
//             //   icons: Icon(Icons.library_books, color: ebookTheme.themeMode().iconColor,),
//             //   onTap: ()=>pushPage(context, EbookExplores()),
//             // ),
//             // NavigationDrawerItemList(
//             //   title: DemoLocalizations.of(context).translate('download'),
//             //   icons: Icon(Icons.file_download, color: ebookTheme.themeMode().iconColor,),
//             //   onTap: ()=>pushPage(context, EbookDownloadPage()),
//             // ),
//             // NavigationDrawerItemList(
//             //   title: DemoLocalizations.of(context).translate('favorite'),
//             //   icons: Icon(Icons.favorite, color: ebookTheme.themeMode().iconColor,),
//             //   onTap: ()=>pushPage(context, EbookFavoritePage()),
//             // ),
//             // NavigationDrawerItemList(
//             //   title: DemoLocalizations.of(context).translate('language'),
//             //   icons: Icon(Icons.language, color: ebookTheme.themeMode().iconColor,),
//             //   onTap: ()=>pushPage(context, LanguageScreen()),
//             // ),
//             // Center(
//             //   child: Text(
//             //     DemoLocalizations.of(context).translate('theme'),
//             //     style: TextStyle(
//             //       fontSize: 19,
//             //       color: Color(0xFF918f95)
//             //     ),
//             //   ),
//             // ),
//             // SizeSpace(number: 10,),
//             // EbookAnimRoute(
//             //     text: [DemoLocalizations.of(context).translate('light'), DemoLocalizations.of(context).translate('dark')],
//             //     changed: (v) async{
//             //       await ebookTheme.toggleThemeData();
//             //       setState(() {
//             //       });
//             //     }),
//           ],
//         ),
//       ),
//     );
//   }
// }
