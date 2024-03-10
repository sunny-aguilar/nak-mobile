import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color blueClr = Color(0xff4e5ae8);
const Color pinkClr = Color(0xffff4667);
const Color redClr = Color.fromARGB(255, 254, 58, 67);
const Color darkGreyClr = Color.fromARGB(255, 56, 56, 58);
const Color greyClr = Colors.grey;
const Color whiteClr = Color(0xffffffff);
const Color offWhiteClr = Color.fromARGB(255, 254, 252, 243);
const Color redOfficial = Color(0xffc41230);
const Color bronzeOfficial = Color(0xffd8c288);
const primaryClr = whiteClr;

// only loads on hot restart
class Themes{
  static final light = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryClr,            // appbar color
      onPrimary: greyClr,
      secondary: greyClr,
      onSecondary: greyClr,
      background: primaryClr,         // main screen color
      onBackground: greyClr,
      surface: greyClr,               // card color
      onSurface: Colors.black,      // font, icons color
      error: greyClr,
      onError: greyClr,
    ),

    // Input field theme
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: darkGreyClr),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyClr),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyClr),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redClr)
      ),
    ),
  );

  static final dark = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: darkGreyClr,                 // appbar color
      onPrimary: greyClr,
      secondary: greyClr,
      onSecondary: greyClr,
      background: darkGreyClr,              // main screen color
      onBackground: greyClr,
      surface: darkGreyClr,                 // card color
      onSurface: Colors.white,            // font, icons color
      error: greyClr,
      onError: greyClr,
    ),

    // Input field theme
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primaryClr),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryClr),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkGreyClr),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redClr)
      ),
    )
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

      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: darkGreyClr),

        border: OutlineInputBorder(),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkGreyClr),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkGreyClr),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redClr)
        ),

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

      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryClr),

        border: OutlineInputBorder(),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryClr),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkGreyClr),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redClr)
        ),

      )
    );
  }
}

/// Create theme data variables for text
class TextThemes{
  static TextStyle drawerTitle(BuildContext context) {
    return const TextStyle(
      color: whiteClr,
      fontFamily: 'College',
      fontSize: 26,
    );
  }

  static TextStyle drawerMenu(BuildContext context) {
    return const TextStyle(
      color: darkGreyClr,
      fontFamily: 'College',
      fontSize: 20,
    );
  }

  static TextStyle drawerMenuNT(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 20,
    );
  }

  static TextStyle chapterCardTitle(BuildContext context) {
    return TextStyle(
      color: Get.isDarkMode ? primaryClr : darkGreyClr,
      fontFamily: 'College',
      fontSize: 18,
    );
  }

  static TextStyle duesTitle(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 28,
    );
  }

  static TextStyle headlineMed(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 22,
    );
  }

  static TextStyle headlineSmall(BuildContext context) {
    return const TextStyle(
      // color: darkGreyClr,
      fontFamily: 'College',
      fontSize: 18,
    );
  }

  static TextStyle headline(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
    );
  }

  static TextStyle button1(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 16,
    );
  }

  static TextStyle modalText(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 22,
      // color: darkGreyClr,
    );
  }

  static TextStyle resourceTitle(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Clarendon',
      fontSize: 36,
      // color: darkGreyClr,
    );
  }

  static TextStyle resourceHeadline(BuildContext context) {
    return const TextStyle(
      fontFamily: 'LuloClean',
      fontSize: 10,
      // color: darkGreyClr,
    );
  }

  static TextStyle resourceBody(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Georgia',
      fontSize: 14,
      // color: darkGreyClr,
    );
  }

}


// font that changes light/dark on theme
TextStyle get dynamicText {
  return TextStyle(
    color: Get.isDarkMode ? primaryClr : darkGreyClr,
    fontSize: 24
  );
}