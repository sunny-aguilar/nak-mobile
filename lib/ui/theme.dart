import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color blueClr = Color(0xff4E5ae8);
const Color saphireClr = Color(0xff0F52BA);
const Color azureClr = Color(0xff0080FF);
const Color purpleClr = Color(0xff6200ea);
const Color violetColor = Color(0xff7C4DFF);
const Color darkBlue = Color(0xFF17203A);
const Color mintClr = Color(0xff9CFC97);
const Color pinkClr = Color(0xffFF4667);
const Color redClr = Color.fromARGB(255, 254, 58, 67);
const Color uiRedClr = Color.fromARGB(255, 237, 56, 73);
const Color carmoisineClr = Color.fromARGB(255, 179, 28, 69);
const Color orangeClr = Color.fromARGB(255, 255, 152, 0);
const Color warningClr = Color.fromARGB(255, 255, 153, 11);
const Color lightRedClr =Color.fromARGB(255, 250, 218, 220);
const Color roseClr = Color.fromARGB(255, 208, 200, 255);
const Color uiGrey = Color.fromARGB(255, 248, 248, 248);
const Color greyUI = Color.fromARGB(255, 56, 61, 67);
const Color chatGregyClr = Color.fromARGB(255, 234, 234, 234);
const Color lightGrey = Color.fromARGB(255, 218, 218, 218);
const Color dividerClr = Color.fromARGB(255, 174, 174, 174);
const Color greyClr = Colors.grey;
const Color shawdowClr = Color.fromARGB(255, 98, 98, 98);
const Color charcoalClr = Color.fromARGB(255, 73, 73, 73);
const Color bodyClr = Color(0xff20211A);
const Color darkGreyClr = Color.fromARGB(255, 45, 45, 45);
const Color zincClr = Color(0xff333333);
const Color graphiteClr = Color(0xff242D36);
const Color carbonClr = Color.fromARGB(255, 20, 20, 20);
const Color blackClr = Color.fromARGB(255, 0, 0, 0);
const Color voidClr = Color(0xff151515);
const Color kColorBackground = Color.fromRGBO(30, 28, 33, 1.0);
const Color whiteClr = Color(0xffFFFFFF);
const Color offWhiteClr = Color.fromARGB(255, 254, 252, 243);
const Color offWhiteClr2 = Color.fromARGB(255, 218, 212, 191);
const Color bronzeAlt = Color.fromARGB(255, 255, 239, 200);
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
      // background: primaryClr,        // main screen color
      onBackground: greyClr,
      surface: primaryClr,            // card color
      onSurface: blackClr,            // font, icons color
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
  //////////////////////////////////////////////////////////////////
  static TextStyle collegeText(BuildContext context) { return const TextStyle(fontFamily: 'College'); }
  static TextStyle latoText(BuildContext context) { return const TextStyle(fontFamily: 'Lato'); }
  static TextStyle clarendonText(BuildContext context) { return const TextStyle(fontFamily: 'Clarendon'); }
  static TextStyle georgiaText(BuildContext context) { return const TextStyle(fontFamily: 'Georgia'); }
  static TextStyle oswaldText(BuildContext context) { return const TextStyle(fontFamily: 'Oswald'); }
  static TextStyle bebasText(BuildContext context) { return const TextStyle(fontFamily: 'Bebas'); }
  static TextStyle diatypeText(BuildContext context) { return const TextStyle(fontFamily: 'Diatype'); }
  static TextStyle spaceMonoText(BuildContext context) { return const TextStyle(fontFamily: 'SpaceMono'); }
  static TextStyle leagueSpartanText(BuildContext context) { return const TextStyle(fontFamily: 'LeagueSpartan'); }
  static TextStyle gabaritoText(BuildContext context) { return const TextStyle(fontFamily: 'Gabarito'); }

  static TextStyle size6(BuildContext context) { return const TextStyle(fontSize: 6.0); }
  static TextStyle size7(BuildContext context) { return const TextStyle(fontSize: 7.0); }
  static TextStyle size8(BuildContext context) { return const TextStyle(fontSize: 8.0); }
  static TextStyle size9(BuildContext context) { return const TextStyle(fontSize: 9.0); }
  static TextStyle size10(BuildContext context) { return const TextStyle(fontSize: 10.0); }
  static TextStyle size11(BuildContext context) { return const TextStyle(fontSize: 11.0); }
  static TextStyle size12(BuildContext context) { return const TextStyle(fontSize: 12.0); }
  static TextStyle size14(BuildContext context) { return const TextStyle(fontSize: 14.0); }
  static TextStyle size15(BuildContext context) { return const TextStyle(fontSize: 15.0); }
  static TextStyle size16(BuildContext context) { return const TextStyle(fontSize: 16.0); }
  static TextStyle size18(BuildContext context) { return const TextStyle(fontSize: 18.0); }
  static TextStyle size20(BuildContext context) { return const TextStyle(fontSize: 20.0); }
  static TextStyle size36(BuildContext context) { return const TextStyle(fontSize: 36.0); }

  static TextStyle colorDark(BuildContext context) { return const TextStyle(color: darkGreyClr); }
  static TextStyle colorPrimary(BuildContext context) { return const TextStyle(color: primaryClr); }

  //////////////////////////////////////////////////////////////////
  // Drawer Component Styles
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

  static TextStyle drawerSignInTxt(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
    );
  }

  //////////////////////////////////////////////////////////////////
  // Card Text Styles
  static TextStyle chapterCardTitle(BuildContext context) {
    return TextStyle(
      color: Get.isDarkMode ? primaryClr : darkGreyClr,
      fontFamily: 'College',
      fontSize: 18,
    );
  }

  //////////////////////////////////////////////////////////////////
  // Headline Styles
  static TextStyle headlineLarge(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 38,
    );
  }

  static TextStyle headlineLargeMed(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 34,
    );
  }

  static TextStyle headlineLarge28(BuildContext context) {
    return const TextStyle(
      fontFamily: 'College',
      fontSize: 28,
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

  static TextStyle headlineSmall20(BuildContext context) {
    return const TextStyle(
      // color: darkGreyClr,
      fontFamily: 'College',
      fontSize: 20,
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

  static TextStyle headlineXSmall14(BuildContext context) {
    return const TextStyle(
      // color: darkGreyClr,
      fontFamily: 'College',
      fontSize: 14,
    );
  }

  static TextStyle headline(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
    );
  }

  //////////////////////////////////////////////////////////////////
  // Button Styles
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

  //////////////////////////////////////////////////////////////////
  // Modal Styles
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

  //////////////////////////////////////////////////////////////////
  // Resource Card Styles
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

  //////////////////////////////////////////////////////////////////
  // Login Styles
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

  static TextStyle bodyLarge24(BuildContext contex) {
    return const TextStyle(
      fontSize: 24,
    );
  }

  static TextStyle bodyLargeBold(BuildContext contex) {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
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

  //////////////////////////////////////////////////////////////////
  // Version Screen Fonts
  static TextStyle versionYear(BuildContext contex) {
    return TextStyle(
      fontFamily: 'SpaceMono',
      fontSize: 175,
      height: 1.0,
      color: Get.isDarkMode ? lightGrey : charcoalClr,
    );
  }

  static TextStyle versionNum(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 18,
      color: darkGreyClr,
    );
  }

  static TextStyle versionHeadline(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.bold,
      fontSize: 60,
      height: 0.90,
      letterSpacing: 1.0,
    );
  }

  static TextStyle versionHeadlineMed(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.bold,
      fontSize: 20,
      height: 0.90,
      letterSpacing: 1.0,
    );
  }

  static TextStyle versionSlogan(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lato',
      color: Get.isDarkMode ? primaryClr : darkGreyClr,
      fontSize: 24,
    );
  }

  static TextStyle versionDesign(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 16,
    );
  }

  static TextStyle chatWarning(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 16,
      // color: redClr,
    );
  }

  static TextStyle chatDate(BuildContext context) {
    return const TextStyle(
      fontSize: 11,
    );
  }

  static TextStyle dynamic(BuildContext context) {
    return TextStyle(
      color: Get.isDarkMode ? primaryClr : darkGreyClr,
      fontSize: 16,
    );
  }

  static TextStyle titleTextStyle(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17.0,
    );
  }

  static TextStyle descriptionTextStyle(BuildContext context) {
    return const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle monoBodySmall18(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Diatype',
      fontSize: 18,
    );
  }

  static TextStyle monoBodyBold700Small18(BuildContext context) {
    return TextStyle(
      fontFamily: 'Diatype',
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Get.isDarkMode ? primaryClr : bodyClr
    );
  }

  static TextStyle monoBodyBold600Med24(BuildContext context) {
    return TextStyle(
      fontFamily: 'Diatype',
      fontWeight: FontWeight.w600,
      fontSize: 24,
      color: Get.isDarkMode ? primaryClr : bodyClr
    );
  }

  static TextStyle gabaritoSize40(BuildContext context) {
    return TextStyle(
        fontFamily: 'Gabarito',
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: Get.isDarkMode ? primaryClr : charcoalClr,
    );
  }

  static TextStyle blogAuthorNames(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Get.isDarkMode ? primaryClr : shawdowClr
    );
  }

  static TextStyle blogDate(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: Get.isDarkMode ? primaryClr : shawdowClr
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