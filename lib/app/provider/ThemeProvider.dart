import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_stickers_internet/app/domain/repositories/preferences_repository.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;

  ThemeProvider() {
    themeMode = _preferences.isDarckMode ? ThemeMode.dark : ThemeMode.light;
  }

  final PreferencesRepository _preferences = Get.i.find();

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    // themeMode = isOn;
    //themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    if (isOn == true) {
      themeMode = ThemeMode.dark;
      _preferences.darkMode(true);
    } else {
      themeMode = ThemeMode.light;
      _preferences.darkMode(false);
    }

    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    // //accentColor: Colors.yellow,
    // accentColorBrightness: Brightness.dark,
    // //accentIconTheme: IconThemeData(color: Colors.red),
    // //accentTextTheme: TextTheme(overline: TextStyle(color: Colors.red)),
    // appBarTheme: AppBarTheme(color: Colors.yellow),
    // applyElevationOverlayColor: true,
    // backgroundColor: Colors.grey.shade800,
    // bannerTheme: MaterialBannerThemeData(backgroundColor: Colors.yellow),
    // bottomAppBarColor: Colors.yellow,
    // bottomAppBarTheme: BottomAppBarTheme(color: Colors.yellow),
    // bottomNavigationBarTheme:
    //     BottomNavigationBarThemeData(backgroundColor: Colors.yellow),
    // bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.yellow),
    // brightness: Brightness.dark,
    // buttonBarTheme: ButtonBarThemeData(alignment: MainAxisAlignment.center),
    // buttonColor: Colors.yellow,
    // buttonTheme: ButtonThemeData(buttonColor: Colors.yellow),
    // canvasColor: Colors.yellow,
    // cardColor: Colors.yellow,
    // cardTheme: CardTheme(
    //   color: Colors.grey.shade900,
    // ),
    // //checkboxTheme: CheckboxThemeData(fillColor: const MaterialStateColor)
    // chipTheme: ChipThemeData(
    //   shadowColor: Colors.yellow,
    //   disabledColor: Colors.yellow,
    //   selectedColor: Colors.yellow,
    //   secondarySelectedColor: Colors.yellow,
    //   labelStyle: TextStyle(color: Colors.yellow),
    //   secondaryLabelStyle: TextStyle(color: Colors.yellow),
    //   brightness: Brightness.dark,
    //   backgroundColor: Colors.yellow,
    //   padding: EdgeInsets.all(0),
    // ),
    // colorScheme: ColorScheme(
    //   background: Colors.yellow,
    //   brightness: Brightness.dark,
    //   primary: Colors.yellow,
    //   secondary: Colors.yellow,
    //   primaryVariant: Colors.yellow,
    //   secondaryVariant: Colors.yellow,
    //   error: Colors.yellow,
    //   onSurface: Colors.yellow,
    //   onPrimary: Colors.yellow,
    //   surface: Colors.yellow,
    //   onError: Colors.yellow,
    //   onBackground: Colors.yellow,
    //   onSecondary: Colors.yellow,
    // ),
    // cupertinoOverrideTheme:
    //     NoDefaultCupertinoThemeData(primaryColor: Colors.yellow),
    // cursorColor: Colors.yellow,
    // //dataTableTheme: DataTableThemeData(dataRowColor: Colors.yellow),
    // dialogBackgroundColor: Colors.yellow,
    // dialogTheme: DialogTheme(backgroundColor: Colors.yellow),
    // disabledColor: Colors.yellow,
    // dividerColor: Colors.yellow,
    // dividerTheme: DividerThemeData(color: Colors.yellow),
    // //elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateColor))
    // errorColor: Colors.yellow,
    // fixTextFieldOutlineLabel: true,
    // floatingActionButtonTheme:
    //     FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
    // focusColor: Colors.yellow,
    // fontFamily: 'arial',
    // highlightColor: Colors.yellow,
    // hintColor: Colors.yellow,
    // hoverColor: Colors.yellow,
    // iconTheme: IconThemeData(color: Colors.yellow),
    // indicatorColor: Colors.yellow,
    // inputDecorationTheme: InputDecorationTheme(hoverColor: Colors.yellow),
    // //materialTapTargetSize: MaterialTapTargetSize(Color(value))
    // navigationRailTheme:
    //     NavigationRailThemeData(backgroundColor: Colors.yellow),
    // //outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(backgroundColor: Colors.yellow))
    //  // pageTransitionsTheme: PageTransitionsTheme(builders: )
    //  platform: TargetPlatform.android,
    //  popupMenuTheme: PopupMenuThemeData(color: Colors.yellow),
    //  primaryColor: Colors.yellow,
    //  primaryColorBrightness: Brightness.dark,
    //  primaryColorDark: Colors.yellow,
    //  primaryColorLight: Colors.yellow,
    //  primaryIconTheme: IconThemeData(color: Colors.yellow),
    //  primarySwatch: Colors.yellow,
    //  primaryTextTheme: TextTheme(overline: TextStyle(color: Colors.yellow)),
    //  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.yellow),
    //  //radioTheme: RadioThemeData()
    //  scaffoldBackgroundColor: Colors.yellow,
    //  //scrollbarTheme: ScrollbarThemeData(trackColor: Colors.yellow)
    //  secondaryHeaderColor: Colors.yellow,
    //  selectedRowColor: Colors.yellow,
    //  shadowColor: Colors.yellow,
    //  sliderTheme: SliderThemeData(overlayColor: Colors.yellow),
    //  snackBarTheme: SnackBarThemeData(backgroundColor: Colors.yellow),
    //  splashColor: Colors.yellow,
    //  //splashFactory: InteractiveInkFeatureFactory()
    //  //switchTheme: SwitchThemeData(overlayColor: MaterialStateProperty.resolveAs(value, states) )
    //  tabBarTheme: TabBarTheme(labelStyle: TextStyle(color: Colors.yellow)),
    //  //textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: ))
    //  textSelectionColor: Colors.yellow,
    //  textSelectionHandleColor: Colors.yellow,
    //  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.yellow) ,
    //  textTheme: TextTheme(overline: TextStyle( color: Colors.yellow)) ,
    //  timePickerTheme: TimePickerThemeData(backgroundColor: Colors.yellow),
    //  toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.yellow),
    //  //switchTheme: SwitchThemeData(overlayColor: Colors.yellow)
    //  toggleableActiveColor: Colors.yellow,
    //  //tooltipTheme: TooltipThemeData(decoration: Decoration())
    //  typography: Typography(white: TextTheme(overline: TextStyle(color: Colors.yellow))),
    //  unselectedWidgetColor: Colors.yellow,
    //  useTextSelectionTheme: true,
    //  visualDensity: VisualDensity(horizontal: 0)

    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      overline: TextStyle(
          color: Colors.yellow,
          decorationColor: Colors.yellow,
          fontSize: 20,
          fontFamily: 'arial'),
    ),
    scaffoldBackgroundColor: Colors.grey.shade800,
    cardColor: Colors.grey.shade900,
    hintColor: Colors.yellow,
    brightness: Brightness.dark,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    backgroundColor: Colors.grey.shade100,
    cardTheme: CardTheme(color: Colors.white),
    hintColor: Colors.blue,
    brightness: Brightness.light,
    textTheme: TextTheme(
        overline: TextStyle(
            color: Colors.black,
            decorationColor: Colors.yellow,
            fontSize: 15,
            fontStyle: FontStyle.normal)),
  );
}
