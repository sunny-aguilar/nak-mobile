import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/drawer.dart';
import '../components/carousel.dart';
import '../components/cards.dart';

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
      drawer: const DrawerComponent(),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: const <Widget>[
          CarouselComponent(),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Divider(),
          ),
          SizedBox(height: 4,),
          Text('This Is a Title'),
          SizedBox(height: 4,),
          LargeGreyPictureCard(imageString:'assets/img/journal.jpg'),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Divider(),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}