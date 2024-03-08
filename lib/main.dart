import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nak_app/splash_screen.dart';
import 'package:nak_app/screens/chapters_screen.dart';
import 'package:nak_app/screens/intro_screeen.dart';
import 'package:nak_app/screens/dues_screen.dart';
import 'package:nak_app/screens/neb_screen.dart';
import 'package:nak_app/screens/resources_screen.dart';
import 'package:nak_app/screens/resource_screen.dart';
import 'package:nak_app/screens/contact_screen.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
      final routes = {
        // "/": (context) => const HomeScreen(),
        '/intro': (context) => const IntroScreen(),
        '/chapters': (context) => const ChapterScreen(),
        '/dues': (context) => const DuesScreen(),
        '/board': (context) => const NationalBoard(),
        '/resources': (context) => const ResourcesScreen(),
        '/drugs': (context) => const ResourceScreen(),
        '/antihazing': (context) => const ResourceScreen(),
        '/antiretaliation': (context) => const ResourceScreen(),
        '/crisismgmt': (context) => const ResourceScreen(),
        '/ethics': (context) => const ResourceScreen(),
        '/samaritan': (context) => const ResourceScreen(),
        '/riskmgmt': (context) => const ResourceScreen(),
        '/sexualmisconduct': (context) => const ResourceScreen(),
        '/mentalhealth': (context) => const ResourceScreen(),
        '/prevention': (context) => const ResourceScreen(),
        '/titleix': (context) => const ResourceScreen(),
        '/contact': (context) => const ContactScreen(),
      };

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      routes: routes,
      home: const SplashScreen(),
      /// use these themes to change from light/dark mode once themes are better organized in
      /// lib/components/theme.dart
      // theme: theme.Themes.light,

      // theme: theme.CustomTheme.lightThemeData(context),
      theme: theme.Themes.light,            /// theme: is the primary default values for light theme
      // theme: ThemeData(
      //   primaryColor: Colors.red,  // appbar color
      //   brightness: Brightness.light, // text color
      //   useMaterial3: false,
      //   inputDecorationTheme: const InputDecorationTheme(
      //     floatingLabelStyle: TextStyle(color: theme.darkGreyClr),

      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: theme.redClr),
      //     ),

      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: theme.blueClr),
      //     )

      //   ),
      // ),

      // darkTheme: theme.CustomTheme.darkThemeData(context),
      darkTheme: theme.Themes.dark,
      // darkTheme: ThemeData(                   /// darkTheme: primary default values for dark theme
      //   primaryColor: Colors.red,
      //   brightness: Brightness.dark,
      //   useMaterial3: false,
      // ),

      /// themeMode: changes the default theme settings (blue, light)
      themeMode: ThemeMode.light,
      // themeMode: service.ThemeService().theme,

      // darkTheme: theme.Themes.dark,
      // theme: ThemeData(
      //   useMaterial3: true,
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //   // primaryColor: const Color.fromARGB(255, 254, 58, 67),
      //   // appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 19, 19, 19)),
      //   // colorScheme: ColorScheme.fromSeed(
      //   //   seedColor: const Color.fromARGB(255, 255, 255, 255),
      //   //   brightness: Brightness.light,
      //   //   primary: Color.fromARGB(255, 254, 58, 67),
      //   // ),
      //   // primarySwatch: Colors.red,
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.grey, // change to another color? making text light grey
      //     cardColor: const Color.fromARGB(255, 243, 243, 243)
      //   ),
      //   textTheme: TextTheme(
      //     displayLarge: const TextStyle(
      //       fontSize: 32,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     displayMedium: const TextStyle(
      //       fontSize: 32,
      //       fontFamily: 'College',
      //     ),
      //     displaySmall: TextStyle(
      //       color: Colors.white.withAlpha(255),
      //       fontSize: 28,
      //       fontFamily: 'College',
      //     ),
      //     titleMedium: TextStyle(
      //       color: Colors.white.withAlpha(50),
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     titleSmall: const TextStyle(
      //       fontSize: 14,
      //       fontFamily: 'College',
      //     ),
      //     titleLarge: const TextStyle(
      //       fontSize: 20,
      //       fontFamily: 'College',
      //     ),
      //     // bodyMedium: const TextStyle(
      //     //   fontSize: 18,
      //     //   fontFamily: 'College',
      //     // ),
      //     bodySmall: const TextStyle(
      //       fontSize: 12,
      //     ),
      //   ),
      // ),
    );
  }
}