import 'package:flutter/material.dart';

const Color blueClr = Color(0xff4e5ae8);
const Color pinkClr = Color(0xffff4667);
const Color darkGreyClr = Color.fromARGB(255, 56, 56, 58);
const Color whiteClr = Color(0xffffffff);
const primaryClr = whiteClr;

// only loads on hot restart
class Themes{
  static final light = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryClr,        // appbar color
      onPrimary: Colors.grey,
      secondary: Colors.grey,
      onSecondary: Colors.grey,
      background: primaryClr,     // main screen color
      onBackground: Colors.grey,
      surface: Colors.grey,
      onSurface: Colors.black,      // font, icons color
      error: Colors.grey,
      onError: Colors.grey,
    ),
  );
  static final dark = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: darkGreyClr,     // appbar color
      onPrimary: Colors.grey,
      secondary: Colors.grey,
      onSecondary: Colors.grey,
      background: darkGreyClr,  // main screen color
      onBackground: Colors.grey,
      surface: Colors.grey,
      onSurface: Colors.white,                      // font, icons color
      error: Colors.grey,
      onError: Colors.grey,
    ),
  );
}

// loads on hot reload (vs hot restart idkw)
class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryClr,        // appbar color
        onPrimary: Colors.grey,
        secondary: Colors.grey,
        onSecondary: Colors.grey,
        background: primaryClr,     // main screen color
        onBackground: Colors.grey,
        surface: Colors.grey,
        onSurface: Colors.black,      // font, icons color
        error: Colors.grey,
        onError: Colors.grey,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: darkGreyClr,     // appbar color
        onPrimary: Colors.grey,
        secondary: Colors.grey,
        onSecondary: Colors.grey,
        background: darkGreyClr,  // main screen color
        onBackground: Colors.grey,
        surface: Colors.grey,
        onSurface: Colors.white,                      // font, icons color
        error: Colors.grey,
        onError: Colors.grey,
      ),
    );
  }
}

/// Create theme data variables for text
class TextThemes{
  static TextStyle text(BuildContext context) {
    return const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontFamily: 'College',
      fontSize: 20,
    );
  }
}

class DrawerTitle{
  static TextStyle text(BuildContext context) {
    return const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontFamily: 'College',
      fontSize: 26,
    );
  }
}