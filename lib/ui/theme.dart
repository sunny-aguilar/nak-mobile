import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color blueClr = Color(0xff4E5ae8);
const Color saphireClr = Color(0xff0F52BA);
const Color azureClr = Color(0xff0080FF);
const Color purpleClr = Color(0xff6200ea);
const Color mintClr = Color(0xff9CFC97);
const Color pinkClr = Color(0xffFF4667);
const Color redClr = Color.fromARGB(255, 254, 58, 67);
const Color roseClr = Color.fromARGB(255, 208, 200, 255);
const Color lightGrey = Color.fromARGB(255, 218, 218, 218);
const Color dividerClr = Color.fromARGB(255, 174, 174, 174);
const Color greyClr = Colors.grey;
const Color shawdowClr = Color.fromARGB(255, 98, 98, 98);
const Color charcoalClr = Color.fromARGB(255, 73, 73, 73);
const Color darkGreyClr = Color.fromARGB(255, 45, 45, 45);
const Color carbonClr = Color.fromARGB(255, 20, 20, 20);
const Color blackClr = Color.fromARGB(255, 0, 0, 0);
const Color whiteClr = Color(0xffFFFFFF);
const Color offWhiteClr = Color.fromARGB(255, 254, 252, 243);
const Color redOfficial = Color(0xffC41230);
const Color bronzeOfficial = Color(0xffD8C288);
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
      surface: primaryClr,            // card color
      onSurface: blackClr,      // font, icons color
      error: greyClr,
      onError: greyClr,
    ),

    // form calendar
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkGreyClr,
      ),
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
      onSurface: primaryClr,            // font, icons color
      error: greyClr,
      onError: greyClr,
    ),

    // form calendar
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryClr,
      ),
    ),

    // Input field theme
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primaryClr),
      border: OutlineInputBorder(),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryClr),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryClr),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redClr)
      ),
    )
  );

  static final calendarLight = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: darkGreyClr,            // current day icon
      onPrimary: primaryClr,
      secondary: greyClr,
      onSecondary: greyClr,
      background: primaryClr,
      onBackground: greyClr,
      surface: primaryClr,
      onSurface: Colors.black,
      error: greyClr,
      onError: greyClr,
    ),
  );

  static final calendarDark = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryClr,            // current day icon
      onPrimary: darkGreyClr,
      secondary: greyClr,
      onSecondary: greyClr,
      background: darkGreyClr,
      onBackground: greyClr,
      surface: darkGreyClr,
      onSurface: primaryClr,
      error: greyClr,
      onError: greyClr,
    ),
  );
}



/// loads on hot reload (vs hot restart idkw)
class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryClr,            // appbar color
        onPrimary: greyClr,
        secondary: greyClr,
        onSecondary: greyClr,
        background: primaryClr,         // main screen color
        onBackground: greyClr,
        surface: primaryClr,            // card color
        onSurface: blackClr,            // font, icons color
        error: greyClr,
        onError: greyClr,
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

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: darkGreyClr,
      ),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: darkGreyClr,                 // appbar color
        onPrimary: greyClr,
        secondary: greyClr,
        onSecondary: greyClr,
        background: darkGreyClr,              // main screen color
        onBackground: greyClr,
        surface: darkGreyClr,                 // card color
        onSurface: primaryClr,            // font, icons color
        error: greyClr,
        onError: greyClr,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryClr),

        border: OutlineInputBorder(),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryClr),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryClr),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redClr)
        ),
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: whiteClr,
      ),
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

  static TextStyle headlineLarge(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 38,
    );
  }

  static TextStyle headlineMedLarge(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 26,
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

  static TextStyle headlineSmall16(BuildContext context) {
    return const TextStyle(
      // color: darkGreyClr,
      fontFamily: 'College',
      fontSize: 16,
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
      // fontFamily: 'Lato',
      fontSize: 20,
    );
  }

  static TextStyle button2(BuildContext context) {
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

  static TextStyle modalBody(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 16,
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

  static TextStyle idTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'College',
      fontSize: 20,
      color: Get.isDarkMode ? primaryClr : primaryClr,
    );
  }

  static TextStyle idUserName(BuildContext context) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Get.isDarkMode ? primaryClr : primaryClr,
    );
  }

  static TextStyle idLabel(BuildContext context) {
    return TextStyle(
      fontFamily: 'Oswald',
      // fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Get.isDarkMode ? primaryClr : primaryClr,
    );
  }

  static TextStyle idBody(BuildContext context) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Get.isDarkMode ? primaryClr : primaryClr,
    );
  }

  static TextStyle idImageTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Get.isDarkMode ? primaryClr : darkGreyClr,
    );
  }

  static TextStyle loginTitle(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 44,
    );
  }

  static TextStyle loginHeadline(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Bebas',
      fontSize: 22,
    );
  }

  static TextStyle loginBody(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  static TextStyle loginDescription(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
  }

  static TextStyle linkBody(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: azureClr,
    );
  }

  static TextStyle bodyLarge(BuildContext contex) {
    return const TextStyle(
      fontSize: 18,
    );
  }

  static TextStyle bodyMedLarge(BuildContext contex) {
    return const TextStyle(
      fontSize: 15,
    );
  }

  static TextStyle bodyMed(BuildContext contex) {
    return const TextStyle(
      fontSize: 12,
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