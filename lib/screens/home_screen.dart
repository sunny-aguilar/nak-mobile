import 'package:flutter/material.dart';
import '../components/cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/nak_letters.png", height: 30.0,),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                "Drawer Header",
                style: TextStyle(
                  color: Colors.white, fontSize: 24
                )
              ),
            ),
            ListTile(
              leading: const Icon(Icons.stacked_bar_chart),
              title: const Text("Intro Screen"),
              onTap: () => Navigator.pushNamed(context, "/intro"),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text("Chapters"),
              onTap: () => Navigator.pushNamed(context, "/chapters"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("Dues"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("National Board"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("NAKstore"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("Alumni Network"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("National Website"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Expanded(
                child: Image.asset("assets/img/rush_nak.png", fit: BoxFit.none, scale: 3.2, alignment: const Alignment(0, -0.9), height: 300,),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const SolidBronzeCard(),
          const SizedBox(
            height: 8,
          ),
          const BlueGreyCard(),
          const LeftClippedCard(),
          const RedCard(),
          const RedOutlineCard(),
          Card(
            color: Colors.amber,
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 130,
                      color: const Color.fromARGB(0, 255, 255, 255),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                      ),
                      child: Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}