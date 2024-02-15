import 'package:flutter/material.dart';
import 'package:nak_app/splash_screen.dart';
import 'screens/chapters_screen.dart';
import 'screens/intro_screeen.dart';

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
          primarySwatch: Colors.red,
          cardColor: const Color.fromARGB(255, 243, 243, 243)
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white.withAlpha(50),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}