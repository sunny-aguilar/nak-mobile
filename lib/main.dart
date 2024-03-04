import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nak_app/splash_screen.dart';
import 'package:nak_app/screens/chapters_screen.dart';
import 'package:nak_app/screens/intro_screeen.dart';
import 'package:nak_app/screens/dues_screen.dart';
import 'package:nak_app/screens/neb_screen.dart';
import 'package:nak_app/screens/resources_screen.dart';
import 'package:nak_app/screens/resource_screen.dart';
import 'package:nak_app/screens/contact_screen.dart';

void main() {
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
        '/resources': (context) => ResourcesScreen(),
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

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      routes: routes,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // primaryColor: const Color.fromARGB(255, 254, 58, 67),
        // appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 19, 19, 19)),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: const Color.fromARGB(255, 255, 255, 255),
        //   brightness: Brightness.light,
        //   primary: Color.fromARGB(255, 254, 58, 67),
        // ),
        // primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey, // change to another color? making text light grey
          cardColor: const Color.fromARGB(255, 243, 243, 243)
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: const TextStyle(
            fontSize: 32,
            fontFamily: 'College',
          ),
          displaySmall: TextStyle(
            color: Colors.white.withAlpha(255),
            fontSize: 28,
            fontFamily: 'College',
          ),
          titleMedium: TextStyle(
            color: Colors.white.withAlpha(50),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: const TextStyle(
            fontSize: 14,
            fontFamily: 'College',
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'College',
          ),
          // bodyMedium: const TextStyle(
          //   fontSize: 18,
          //   fontFamily: 'College',
          // ),
          bodySmall: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}