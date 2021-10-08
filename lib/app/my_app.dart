import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stickers_internet/app/provider/ThemeProvider.dart';
import 'package:flutter_stickers_internet/app/services/NotificationsService.dart';
import 'package:flutter_stickers_internet/app/ui/routes/app_routes.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:sizer/sizer.dart';

import 'widget/favorite/wa_detail.dart';
import 'widget/favorite/wa_favorite_notif.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
          ChangeNotifierProvider(create: (_) => WaFavoriteNotif()),
       ChangeNotifierProvider(create: (_) => WaDetail()),
      ],
      child: MaterilAppTheme(),
    );
  }
}

class MaterilAppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
      // final orientationn = Orientation.portrait;
        return Sizer(
     
      builder: (context, portrait, deviceType) {
   
        return  MaterialApp(
    
       key: router.appKey,
       title: 'Sticker Fun',
       navigatorKey: router.navigatorKey,
       initialRoute: Routes.SPLASH,
       navigatorObservers: [router.observer],
       routes: appRoutes,
       scaffoldMessengerKey: NotificationsService.messengerKey,
       debugShowCheckedModeBanner: false,
       theme: MyThemes.lightTheme,
       themeMode: themeProvider.themeMode,
       darkTheme: MyThemes.darkTheme,
     );
      },
    );
      
  
}}
// MaterialApp(
//       key: router.appKey,
//       title: 'Sticker Fun',
//       navigatorKey: router.navigatorKey,
//       initialRoute: Routes.SPLASH,
//       navigatorObservers: [router.observer],
//       routes: appRoutes,
//       scaffoldMessengerKey: NotificationsService.messengerKey,
//       debugShowCheckedModeBanner: false,
//       theme: MyThemes.lightTheme,
//       themeMode: themeProvider.themeMode,
//       darkTheme: MyThemes.darkTheme,
//     );