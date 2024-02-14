import 'package:flutter/material.dart';
import 'package:nak_app/splash_screen.dart';
import "screens/home_screen.dart";
import "screens/chapters_screen.dart";
import "screens/intro_screeen.dart";

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
      final routes = {
        // "/": (context) => const HomeScreen(),
        "/chapters": (context) => const ChapterScreen(),
        "/intro": (context) => const IntroScreen(),
      };

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      routes: routes,
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 196, 18, 48),
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white.withAlpha(50),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}