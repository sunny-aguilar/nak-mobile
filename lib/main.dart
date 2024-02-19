import 'package:flutter/material.dart';
import 'package:nak_app/splash_screen.dart';
import 'package:nak_app/screens/chapters_screen.dart';
import 'package:nak_app/screens/intro_screeen.dart';
import 'package:nak_app/screens/dues_screen.dart';
import 'package:nak_app/screens/national_board.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
      final routes = {
        // "/": (context) => const HomeScreen(),
        "/intro": (context) => const IntroScreen(),
        "/chapters": (context) => const ChapterScreen(),
        "/dues": (context) => const DuesScreen(),
        "/board": (context) => const NationalBoard(),
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
          primarySwatch: Colors.grey,
          cardColor: const Color.fromARGB(255, 243, 243, 243)
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: const TextStyle(
            fontSize: 32,
            fontFamily: "College",
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
            fontFamily: "College",
          ),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: "College",
          ),
          bodySmall: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}