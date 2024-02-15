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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 254, 58, 67),
              ),
              child: Text(
                "Nu Alpha Kappa Fraternity",
                style: TextStyle(
                  color: Colors.white, fontSize: 24
                )
              ),
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village),
              title: const Text("Chapters"),
              onTap: () => Navigator.pushNamed(context, "/chapters"),
            ),
            const ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Dues"),
            ),
            const ListTile(
              leading: Icon(Icons.remember_me),
              title: Text("National Board"),
            ),
            const ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("NAKstore"),
            ),
            const ListTile(
              leading: Icon(Icons.school),
              title: Text("Alumni Network"),
            ),
            const ListTile(
              leading: Icon(Icons.public),
              title: Text("National Website"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          FittedBox(
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
          // GridView.count(
          //   crossAxisCount: 2,
          //   children: List.generate(8, (index) {
          //     return Center(
          //       child: Text('Index $index'),
          //     );
          //   }),
          // ),
          const SizedBox(
            height: 8,
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
            height: 8,
          ),
          const PurpleCard(),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}