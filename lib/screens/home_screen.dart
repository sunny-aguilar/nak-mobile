import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/drawer.dart';
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
        children: <Widget>[
          Container(
            // borderRadius: BorderRadius.circular(0.0),
            child: Image.asset(
              'assets/img/image_wireframe1.png',
              fit: BoxFit.fitHeight,
              // scale: 2.0,
              // alignment: const Alignment(0, -0.9),
              // height: 300,
              // color: Color.fromARGB(255, 255, 255, 255),
              // colorBlendMode: BlendMode.modulate,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          const SizedBox(height: 4,),
          // const GridCards(),
          // const SizedBox(height: 8,),
          // const LargeGreyPictureCard(imageString: 'assets/img/nak_letters_bw.png',),
          // const SizedBox(height: 8,),
          // const LargeGreyPictureCard(imageString: 'assets/img/nak_letters_bw.png',),
          // const SizedBox(height: 8,),
          // const LightGrayCard(),
          // const SizedBox(height: 8,),
          // const WhiteRedAccentCard(),
          // const SizedBox(height: 8,),
          // const RedSquareCard(),
          // const SizedBox(height: 8,),
          // const PurpleSquareCard(),
          // const SizedBox(height: 18,),
        ],
      ),
    );
  }
}