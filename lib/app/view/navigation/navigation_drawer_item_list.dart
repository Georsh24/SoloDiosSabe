// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class NavigationDrawerItemList extends StatelessWidget {

//   final String title;
//   final Function onTap;
//   final Icon icons;

//   NavigationDrawerItemList({required this.title, required this.onTap, required this.icons});

//   @override
//   Widget build(BuildContext context) {
//     //final ebookTheme = Provider.of<EbookTheme>(context);
//     return Container(
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.white70, //ebookTheme.themeMode().backgroundColor,
//                     blurRadius: 2
//                 )
//               ]
//           ),
//           child: ListTile(
//             leading: icons,
//             title: Text(
//                 title,
//                 style: TextStyle(
//                     color: Colors.black, //ebookTheme.themeMode().textColor,
//                     fontSize: 18
//                 )
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
