import 'package:flutter/material.dart';
import "screens/home_screen.dart";
import "screens/chapters_screen.dart";

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
      final routes = {
        "/": (context) => const HomeScreen(),
        "/chapters": (context) => const ChapterScreen(),
      };

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: routes,
    );
  }
}


