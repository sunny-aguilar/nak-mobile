import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
// import '../components/carousel.dart';
// import '../components/cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // backgroundColor: Color.fromARGB(255, 255, 54, 54),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const drawer.DrawerComponent(),
      body: const featured.HomeScreenChildren(),
    );
  }
}

