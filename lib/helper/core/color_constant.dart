import 'package:flutter/material.dart';

class AppColoring {
  static MaterialColor primaryApp = const MaterialColor(
    0xff4f73fc,
    <int, Color>{
      50: kAppColor,
      100: kAppColor,
      200: kAppColor,
      300: kAppColor,
      400: kAppColor,
      500: kAppColor,
      600: kAppColor,
      700: kAppColor,
      800: kAppColor,
      900: kAppColor,
    },
  );
  static const kAppColor = Color(0xff4f73fc);
  static const kAppSecondaryColor = Color.fromARGB(255, 160, 173, 223);
  static const kAppBlueColor = Color(0xffF1F9FE);
  static const kAppWhiteColor = Colors.white;
  static const primeryBorder = Color.fromARGB(255, 154, 220, 126);

  //text color

  static const Color textDark = Color(0xFF191919);
  static const Color textLight = Color(0xFF434343);
  static const Color textDim = Color(0xFF7D7D7D);
  static const Color textRed = Color(0xFFFC2424);
  static const Color textGreen = Color.fromARGB(255, 36, 166, 49);

  static const Color textwhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xff84c441);

  //popUpcolors
  static const Color successPopup = Colors.green;
  static const Color yellow = Colors.yellow;
  static const Color errorPopUp = Colors.red;
  static const Color black = Colors.black;
  static const Color blackLight = Color(0xff28242c);
  static const lightBg = Color.fromARGB(255, 223, 237, 255);

  static Color primaryWhite = const Color(0xFFCADCED);
  // static Color primaryWhite = Colors.indigo[100];

  static List pieColors = [
    Colors.indigo[400],
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.deepOrange,
    Colors.brown,
  ];
  static List<BoxShadow> neumorpShadow = [
    BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: -5,
        offset: const Offset(-5, -5),
        blurRadius: 30),
    BoxShadow(
        color: primaryWhite.withOpacity(.2),
        spreadRadius: 2,
        offset: const Offset(7, 7),
        blurRadius: 20)
  ];

  static List<BoxShadow> containerShadow = [
    BoxShadow(
      color: AppColoring.kAppColor.withOpacity(.1),
    ),
  ];
}
