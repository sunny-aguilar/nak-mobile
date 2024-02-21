import 'package:flutter/material.dart';
import '../components/cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // backgroundColor: Color.fromARGB(255, 255, 54, 54),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 254, 58, 67),
              ),
              child: Text(
                "Nu Alpha Kappa Fraternity, Inc.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village),
              title: Text("Chapters", style: Theme.of(context).textTheme.titleLarge!),
              onTap: () => Navigator.pushNamed(context, "/chapters"),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: Text("Dues", style: Theme.of(context).textTheme.titleLarge!),
              onTap: () => Navigator.pushNamed(context, "/dues"),
            ),
            ListTile(
              leading: const Icon(Icons.remember_me),
              title: Text("National Board", style: Theme.of(context).textTheme.titleLarge!),
              onTap: () => Navigator.pushNamed(context, "/board"),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: Text("NAKstore", style: Theme.of(context).textTheme.titleLarge!),
            ),
            ListTile(
              leading: const Icon(Icons.local_library),
              title: Text("Resources", style: Theme.of(context).textTheme.titleLarge!),
              onTap: () => Navigator.pushNamed(context, "/resources"),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: Text("Alumni Network", style: Theme.of(context).textTheme.titleLarge!),
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: Text("National Website", style: Theme.of(context).textTheme.titleLarge!),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text("Contact Us", style: Theme.of(context).textTheme.titleLarge!),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          Container(
            // borderRadius: BorderRadius.circular(0.0),
            child: Image.asset(
              "assets/img/image_wireframe1.png",
              fit: BoxFit.fitHeight,
              // scale: 2.0,
              // alignment: const Alignment(0, -0.9),
              // height: 300,
              // color: Color.fromARGB(255, 255, 255, 255),
              // colorBlendMode: BlendMode.modulate,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          // const GridCards(),
          const SizedBox(
            height: 8,
          ),
          const LargeGreyPictureCard(imageString: "assets/img/nak_letters_bw.png",),
          const SizedBox(
            height: 8,
          ),
          const LargeGreyPictureCard(imageString: "assets/img/nak_letters_bw.png",),
          const SizedBox(
            height: 8,
          ),
          const LightGrayCard(),
          const SizedBox(
            height: 8,
          ),
          const WhiteRedAccentCard(),
          const SizedBox(
            height: 8,
          ),
          const RedSquareCard(),
          const SizedBox(
            height: 8,
          ),
          const PurpleSquareCard(),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}